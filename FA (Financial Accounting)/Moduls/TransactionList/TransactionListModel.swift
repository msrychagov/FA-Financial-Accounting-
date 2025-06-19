//
//  TransactionModel.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.06.2025.
//

import Foundation

@MainActor
final class TransactionListModel: ObservableObject {
    // Загулшка транзакций, так как крашится при использовании сервиса - надо разбираться
    @Published
    var transactions: [Transaction] = []
    
    var direction: Direction
    
    var sum: Decimal {
        var sum: Decimal = 0
        for transaction in transactions {
            sum += transaction.amount
        }
        return sum
    }
    
    init(direction: Direction) {
        self.direction = direction
        Task {
            try await loadTransactions()
            filter()
        }
    }
    var service: TransactionsService = TransactionsService()

    func filter() {
        transactions = transactions.filter { $0.category.isIncome == direction }
    }
    
    func loadTransactions() async throws {
        let calendar = Calendar.current
        /// Установил 03:00:00, потому что по дефолту дата получается, как я понял, в UTC,
        /// т.е. если указать bySettingHour: 0, stratOfDay будет 21:00 предыдущего дня
        let startOfToday = calendar.date(
            bySettingHour: 3,
            minute: 0,
            second: 0,
            of: Date()
        )!
        let endOfToday = calendar.date(byAdding: DateComponents(day:1, second: -1), to: startOfToday)!
        let transactionsFromService = try await service.fetchTransactions(
            startDate: startOfToday,
            endDate: endOfToday
        )
        self.transactions = transactionsFromService
    }
    
}
