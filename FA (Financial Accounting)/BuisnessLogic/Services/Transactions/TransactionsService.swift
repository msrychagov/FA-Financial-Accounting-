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
        guard let transactions: [TransactionDTO] = try await networkClient.request(
            endpoint: TransactionEndpoints.list(
                accountId: accountId,
                startDate: startDate,
                endDate: endDate
            )
        ) else {
            throw Errors.emptyTransaction
        }
        
        return transactions
    }
    
    func createTransaction(
        accountId: Int,
        categoryId: Int,
        amount: Decimal,
        transactionDate: Date,
        comment: String
    ) async throws -> CreateTransactionDTO {
        let endpoint = TransactionEndpoints.create
        let toCreateTransaction = CreateTransactionModel(
            accountId: accountId,
            categoryId: categoryId,
            amount: amount,
            transactionDate: transactionDate.toString(),
            comment: comment
        )
        
        guard let newTransaction: CreateTransactionDTO = try await networkClient.request(body: toCreateTransaction, endpoint: endpoint) else {
            throw Errors.emptyTransaction
        }
        return newTransaction
    }
    
    //TODO: - Проверять, что транзакция с таким id существует
    func fetchTransactionDetails(id: Int) async throws -> TransactionDTO {
        let endpoint = TransactionEndpoints.details(id: id)
        guard let transaction: TransactionDTO = try await networkClient.request(endpoint: endpoint) else {
            throw Errors.emptyTransaction
        }
        return transaction
    }
    
    func updateTransaction(id: Int, accountId: Int, categoryId: Int, amount: Decimal, transactionDate: Date, comment: String) async throws -> TransactionDTO {
        let endpoint = TransactionEndpoints.put(id: id)
        let toUpdateTransaction = UpdateTransactionModel(accountId: accountId, categoryId: categoryId, amount: amount, transactionDate: transactionDate.toString(), comment: comment)
        guard let updatedTransaction: TransactionDTO = try await networkClient.request(body: toUpdateTransaction, endpoint: endpoint) else {
            throw Errors.emptyTransaction
        }
        return updatedTransaction
    }
    
    func deleteTransaction(id: Int) async throws {
        let endpoint = TransactionEndpoints.delete(id: id)
        let emptyResponse: EmptyResponse? = try await networkClient.request(endpoint: endpoint)
    }
}
