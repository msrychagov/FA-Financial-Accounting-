//
//  TransactionModel.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.06.2025.
//

import Foundation
import Observation

@Observable
final class TransactionListModel {
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
//        Task {
//            try await fetch()
//            filter()
//        }
    }
    var service: TransactionsService = TransactionsService()

    func filter() {
        transactions = transactions.filter { $0.category.isIncome == direction }
    }
    
    func fetch(startDate: Date, endDate: Date) async throws {
        transactions = try await service.fetchTransactions(
            startDate: startDate,
            endDate: endDate
        )
        filter()
    }
    
}
