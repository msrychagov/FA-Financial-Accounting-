import Foundation

final class TransactionsService {
    private let repo: TransactionsRepository
    private let storage: OfflineTransactionsStorage
    private let backUp: UnsyncedTransactionsStorage
    
    init(repo: TransactionsRepository = TransactionsRepository(), storage: OfflineTransactionsStorage, backUp: UnsyncedTransactionsStorage) {
        self.repo = repo
        self.storage = storage
        self.backUp = backUp
    }
    
    func fetchTransactions(
        accountId: Int,
        from startDate: Date = Date.startBorder,
        to endDate: Date = Date.endBorder
    ) async throws -> [TransactionEntity] {
        var fetchedTransactions: [TransactionEntity] = []
        var syncedOperations: Set<UnsyncedOperationEntity> = []
        let unsyncedOperations = try await backUp.fetchAll()
        for operation in unsyncedOperations {
                let transaction = operation.transaction
                switch operation.type {
                case .create:
                    try await createTransaction(
                        accountId: transaction.account.id,
                        categoryId: transaction.category.id,
                        amount: transaction.amount,
                        transactionDate: transaction.transactionDate,
                        comment: transaction.comment
                    )
                case .delete:
                    try await deleteTransaction(id: transaction.id)
                case .put:
                    try await updateTransaction(
                        id: transaction.id,
                        accountId: transaction.account.id,
                        categoryId: transaction.category.id,
                        amount: transaction.amount,
                        transactionDate: transaction.transactionDate,
                        comment: transaction.comment
                    )
                }
                syncedOperations.insert(operation)
                try await backUp.delete(operation)
        }
        do {
            let transactions = try await repo.fetchTransactionsList(accountId: accountId, from: startDate, to: endDate)
            for transaction in transactions {
                let transactionEntity = TransactionToEntityMapper().map(transaction)
                try await storage.create(value: transactionEntity)
            }
        } catch {
            fetchedTransactions = try await mergeTransactions(unsyncedOperations: unsyncedOperations, syncedTransactions: syncedOperations)
        }
        return fetchedTransactions
    }
    
    func createTransaction(
        accountId: Int,
        categoryId: Int,
        amount: Decimal,
        transactionDate: Date,
        comment: String
    ) async throws -> Transaction {
        let newTransaction = try await repo.createTransaction(
            accountId: accountId,
            categoryId: categoryId,
            amount: amount,
            transactionDate: transactionDate,
            comment: comment
        )
        return newTransaction
    }
    
    //TODO: - Проверять, что транзакция с таким id существует
    func fetchTransactionDetails(id: Int) async throws -> Transaction {
        let transaction = try await repo.fetchTransactionDetails(id: id)
        return transaction
    }
    
    func updateTransaction(id: Int, accountId: Int, categoryId: Int, amount: Decimal, transactionDate: Date, comment: String) async throws -> Transaction {
        let updatedTransaction = try await repo.updateTransaction(
            id: id,
            accountId: accountId,
            categoryId: categoryId,
            amount: amount,
            transactionDate: transactionDate,
            comment: comment
        )
        return updatedTransaction
    }
    
    func deleteTransaction(id: Int) async throws {
        try await repo.deleteTransaction(id: id)
    }
    
    func mergeTransactions(unsyncedOperations: [UnsyncedOperationEntity], syncedTransactions: Set<UnsyncedOperationEntity>) async throws -> [TransactionEntity] {
        var mergedTransactions: Set<TransactionEntity> = []
        for operation in unsyncedOperations {
            /// Если не синхронизировали операцию или синхронизировали и не удалили
            if (!syncedTransactions.contains(operation) || syncedTransactions.contains(operation) && operation.type != .delete){
                mergedTransactions.insert(operation.transaction)
            }
        }
        
        let savedTransactions = try await storage.fetchAll()
        for transaction in savedTransactions {
            mergedTransactions.insert(transaction)
        }
        
        return Array(mergedTransactions)
    }
}
