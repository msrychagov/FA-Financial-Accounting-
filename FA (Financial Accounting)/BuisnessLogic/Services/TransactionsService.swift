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
}
