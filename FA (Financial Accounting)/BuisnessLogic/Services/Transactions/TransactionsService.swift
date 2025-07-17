import Foundation

final class TransactionsService {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = NetworkClient()) {
        self.networkClient = networkClient
    }
    
    func fetchTransactions(
        accountId: Int,
        from startDate: Date = Date.startBorder,
        to endDate: Date = Date.endBorder
    ) async throws -> [TransactionDTO] {
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
    ) async throws -> TransactionDTO {
        let endpoint = TransactionEndpoints.create
        let toCreateTransaction = CreateTransactionModel(
            accountId: accountId,
            categoryId: categoryId,
            amount: amount,
            transactionDate: transactionDate,
            comment: comment
        )
        
        let newTransaction: TransactionDTO = try await networkClient.request(body: toCreateTransaction, endpoint: endpoint)
        return newTransaction
    }
    
    //TODO: - Проверять, что транзакция с таким id существует
    func fetchTransactionDetails(id: Int) async throws -> TransactionDTO {
        let endpoint = TransactionEndpoints.details(id: id)
        let transaction: TransactionDTO = try await networkClient.request(endpoint: endpoint)
        return transaction
    }
    
    func updateTransaction(id: Int, accountId: Int, categoryId: Int, amount: Decimal, transactionDate: Date, comment: String) async throws -> TransactionDTO {
        let endpoint = TransactionEndpoints.put(id: id)
        let toUpdateTransaction = UpdateTransactionModel(accountId: accountId, categoryId: categoryId, amount: amount, transactionDate: transactionDate, comment: comment)
        let updatedTransaction: TransactionDTO = try await networkClient.request(body: toUpdateTransaction, endpoint: endpoint)
        return updatedTransaction
    }
    
    func deleteTransaction(id: Int) async throws -> TransactionDTO {
        let endpoint = TransactionEndpoints.delete(id: id)
        let deletedTransaction: TransactionDTO = try await networkClient.request(endpoint: endpoint)
        return deletedTransaction
    }
}
