import Foundation

final class TransactionsService {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchTransactions(
        accountId: String,
        from startDate: Date = Date.startBorder,
        to endDate: Date = Date.endBorder
    ) async throws -> [Transaction] {
        return try await networkClient.request(
            endpoint: TransactionEndpoints.list(
                accountId: accountId,
                startDate: startDate,
                endDate: endDate
            )
        )
    }
    
    func createTransaction(
        accountId: Int,
        categoryId: Int,
        amount: Decimal,
        transactionDate: Date,
        comment: String
    ) async throws -> Transaction {
        let endpoint = TransactionEndpoints.create
        let toCreateTransaction = CreateTransactionModel(
            accountId: accountId,
            categoryId: categoryId,
            amount: amount,
            transactionDate: transactionDate,
            comment: comment
        )
        
        let newTransaction: Transaction = try await networkClient.request(body: toCreateTransaction, endpoint: endpoint)
        return newTransaction
    }
    
    //TODO: - Проверять, что транзакция с таким id существует
    func fetchTransactionDetails(id: Int) async throws -> Transaction {
        let endpoint = TransactionEndpoints.details(id: id)
        let transaction: Transaction = try await networkClient.request(endpoint: endpoint)
        return transaction
    }
    
    func updateTransaction(id: Int, accountId: Int, categoryId: Int, amount: Decimal, transactionDate: Date, comment: String) async throws -> Transaction {
        let endpoint = TransactionEndpoints.put(id: id)
        let toUpdateTransaction = UpdateTransactionModel(accountId: accountId, categoryId: categoryId, amount: amount, transactionDate: transactionDate, comment: comment)
        let updatedTransaction: Transaction = try await networkClient.request(body: toUpdateTransaction, endpoint: endpoint)
        return updatedTransaction
    }
    
    func deleteTransaction(id: Int) async throws -> Transaction {
        let endpoint = TransactionEndpoints.delete(id: id)
        let deletedTransaction: Transaction = try await networkClient.request(endpoint: endpoint)
        return deletedTransaction
    }
}
