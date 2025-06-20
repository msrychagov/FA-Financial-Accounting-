//
//  TransactionModel.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.06.2025.
//

import Foundation
import Observation

enum SortCriteria {
    case date, amount
}
@Observable
final class TransactionListModel {
    private(set) var transactions: [Transaction] = []
    let direction: Direction
    private let service: TransactionsService = TransactionsService()
    
    var sum: Decimal {
        var sum: Decimal = 0
        for transaction in transactions {
            sum += transaction.amount
        }
        return sum
    }
    
    // Добавить TransactionService
    init(direction: Direction) {
        self.direction = direction
        //        Task {
        //            try await fetch()
        //            filter()
        //        }
    }
    
    func filter() {
        transactions = transactions.filter { $0.category.isIncome == direction }
    }
    
    func sort(by criteria: SortCriteria, ascending: Bool) {
        switch criteria {
        case .amount:
            switch ascending {
            case true:
                transactions.sort(by: { $0.amount < $1.amount } )
            case false:
                transactions.sort(by: { $0.amount > $1.amount })
            }
        case .date:
            switch ascending {
            case true:
                transactions.sort(by: { $0.transactionDate < $1.transactionDate })
            case false:
                transactions.sort (by: { $0.transactionDate > $1.transactionDate })
            }
        }
        
        
    }
    
    func fetch(startDate: Date, endDate: Date) async throws {
        transactions = try await service.fetchTransactions(
            startDate: startDate,
            endDate: endDate
        )
        filter()
    }
    
}
