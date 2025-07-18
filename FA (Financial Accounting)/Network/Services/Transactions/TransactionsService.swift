import Foundation

final class TransactionsService {
    private let repo: TransactionsRepository
    private let storage: OfflineTransactionsStorage
    private let backUp: UnsyncedTransactionsStorage
    
    init(repo: TransactionsRepository = TransactionsRepository(), storage: OfflineTransactionsStorage) {
        self.repo = repo
        self.storage = storage
    }
    
    func fetchTransactions(
        accountId: Int,
        from startDate: Date = Date.startBorder,
        to endDate: Date = Date.endBorder
    ) async throws -> [Transaction] {
        let transactions = try await repo.fetchTransactionsList(accountId: accountId, from: startDate, to: endDate)
        return transactions
    }
    
    func createTransaction(
        accountId: Int,
        categoryId: Int,
        amount: String,
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
}
