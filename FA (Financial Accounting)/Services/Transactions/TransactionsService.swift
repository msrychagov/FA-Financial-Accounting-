import Foundation


final class TransactionsService {
    private let repo: TransactionsRepository
    private let storage: SwiftDataTransactionsStorage
    private let accountsStorage: SwiftDataAccountsStorage
    private let categoriesStorage: SwiftDataCategoriesStorage
    private let backup: SwiftDataBackupTransactionsOperations
    
    init(
        repo: TransactionsRepository = TransactionsRepository(),
        storage: SwiftDataTransactionsStorage,
        accountsStorage: SwiftDataAccountsStorage,
        categoriesStorage: SwiftDataCategoriesStorage,
        backup: SwiftDataBackupTransactionsOperations
    ) {
        self.repo = repo
        self.storage = storage
        self.accountsStorage = accountsStorage
        self.categoriesStorage = categoriesStorage
        self.backup = backup
    }
    
    func fetchTransactions(
        accountId: Int,
        from startDate: Date = Date.startBorder,
        to endDate: Date = Date.endBorder
    ) async throws -> [Transaction] {
        try? await syncOperations()
        do {
            let transactions = try await repo.fetchTransactionsList(accountId: accountId, from: startDate, to: endDate)
            try await saveToStorage(transactions)
            return transactions
        } catch {
            let local = try await storage.fetch(from: startDate, to: endDate)
            let unsyncedOperations = try await backup.operations
            let merged = try await apply(unsyncedOperations, to: local)
            return merged
        }
    }
    
    func createTransaction(
        accountId: Int,
        categoryId: Int,
        amount: Decimal,
        transactionDate: Date,
        comment: String
    ) async throws {
        let transactionRequest = TransactionRequestBody(
            accountId: accountId,
            categoryId: categoryId,
            amount: amount,
            transactionDate: transactionDate.toString(),
            comment: comment
        )
        do {
            let _ = try await repo.createTransaction(request: transactionRequest)
        } catch {
            let localId = try await generateUniqueLocalId()
            let operation = TransactionsOperation(transactionId: localId, type: .create, transactionRequest: transactionRequest)
            try await backup.saveOperation(operation)
        }
    }
    
    //TODO: - Проверять, что транзакция с таким id существует
    func fetchTransactionDetails(id: Int) async throws -> Transaction {
        do {
            return try await repo.fetchTransactionDetails(id: id)
        } catch {
            return try await storage.getTransaction(id: id)
        }
    }
    
    func updateTransaction(id: Int, accountId: Int, categoryId: Int, amount: Decimal, transactionDate: Date, comment: String) async throws {
        
        do {
            let transaction = try await repo.updateTransaction(id: id, accountId: accountId, categoryId: categoryId, amount: amount, transactionDate: transactionDate, comment: comment)
            try await storage.update(transaction)
        } catch {
            let request = TransactionRequestBody(accountId: accountId, categoryId: categoryId, amount: amount, transactionDate: transactionDate.toString(), comment: comment)
            let operation = TransactionsOperation(transactionId: id, type: .update, transactionRequest: request)
            try await backup.saveOperation(operation)
        }
    }
    
    func deleteTransaction(id: Int) async throws {
        do {
            try await repo.deleteTransaction(id: id)
        } catch {
            let transaction = try await storage.getTransaction(id: id)
            let request = TransactionRequestBody(accountId: transaction.account.id, categoryId: transaction.category.id, amount: transaction.amount, transactionDate: transaction.transactionDate.toString(), comment: transaction.comment)
            let operation = TransactionsOperation(transactionId: id, type: .delete, transactionRequest: request)
            try await backup.saveOperation(operation)
            try await storage.delete(for: id)
        }
    }
}

private extension TransactionsService {
    private func saveToStorage(_ transactions: [Transaction]) async throws {
        for transaction in transactions {
            try await storage.save(transaction)
        }
    }
    
    func generateUniqueLocalId() async throws -> Int {
        let existingIds = Set(try await storage.fetchAll().map { $0.id })
        var newId: Int
        
        repeat {
            newId = -Int.random(in: 1...Int.max)
        } while existingIds.contains(newId)
        
        return newId
    }
    
    func syncOperations() async throws {
        let unsyncedOperations = try await backup.operations
        for operation in unsyncedOperations {
            let request = operation.transactionRequest
            switch operation.type {
            case .create:
                let serverTransaction = try await repo.createTransaction(request: request)
                try await storage.delete(for: operation.transactionId)
                try await storage.save(serverTransaction)
            case .update:
                let serverTransaction = try await repo.updateTransaction(id: operation.transactionId, accountId: request.accountId, categoryId: request.categoryId, amount: request.amount, transactionDate: request.transactionDate.convertToDate(), comment: request.comment)
                try await storage.update(serverTransaction)
            case .delete:
                try await repo.deleteTransaction(id: operation.transactionId)
                try await storage.delete(for: operation.transactionId)
            }
            try await backup.removeOpeartion(with: operation.id)
        }
    }
    
    func makeTransaction(from request: TransactionRequestBody, with id: Int) async throws -> Transaction {
        let account = try await accountsStorage.account(for: request.accountId).toTransactionBankAccount()
        let category = try await categoriesStorage.category(for: request.categoryId)
        return Transaction(
            id: id,
            account: account,
            category: category,
            amount: request.amount,
            transactionDate: request.transactionDate.convertToDate(),
            comment: request.comment,
            createdAt: Date(),
            updatedAt: Date()
        )
    }
    
    func apply(
        _ operations: [TransactionsOperation],
        to transactions: [Transaction]
    ) async throws -> [Transaction] {
        var dict = Dictionary(uniqueKeysWithValues: transactions.map { ($0.id, $0) })

        for op in operations {
            switch op.type {
            case .create:
                if dict[op.transactionId] == nil {
                    let tx = try await makeTransaction(from: op.transactionRequest, with: op.transactionId)
                    dict[tx.id] = tx
                }

            case .update:
                if let existing = dict[op.transactionId] {
                    let request = op.transactionRequest
                    let account = try await accountsStorage.account(for: request.accountId).toTransactionBankAccount()
                    let category = try await categoriesStorage.category(for: request.categoryId)
                    dict[existing.id] = existing.updating(with: op.transactionRequest, account: account, category: category)
                }

            case .delete:
                dict.removeValue(forKey: op.transactionId)
            }
        }
        return Array(dict.values)
    }
}

extension Transaction {
    func updating(with request: TransactionRequestBody, account: TransactionBankAccount, category: Category) -> Transaction {
        Transaction(
            id: id,
            account: account,
            category: category,
            amount: request.amount,
            transactionDate: request.transactionDate.convertToDate(),
            comment: request.comment,
            createdAt: createdAt,
            updatedAt: Date()
        )
    }
}
