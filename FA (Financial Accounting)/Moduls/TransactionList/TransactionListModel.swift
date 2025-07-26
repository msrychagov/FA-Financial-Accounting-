//
//  TransactionModel.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.06.2025.
//

import Foundation
import Observation
import SwiftUI

enum SortCriteria {
    case date, amount
}

final class TransactionListModel:ObservableObject {
    @Published private(set) var transactions: [Transaction] = []
    let direction: Direction
    let service: TransactionsService
    var viewState: ViewState
    var alertItem: AlertItem?
    
    var sum: Decimal {
        var sum: Decimal = 0
        for transaction in transactions {
            sum += transaction.amount
        }
        return sum
    }
    
    // Добавить TransactionService
    init(direction: Direction, service: TransactionsService = ServiceFactory.shared.createTransactionsService()) {
        self.direction = direction
        //        Task {
        //            try await fetch()
        //            filter()
        //        }
        viewState = .idle
        self.service = service
    }
    
    func filter() {
        transactions = transactions.filter { $0.category.direction == direction }
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
    
    @MainActor
    func fetch(startDate: Date, endDate: Date) async throws {
        do {
            viewState = .loading
            transactions = try await service.fetchTransactions(accountId: 820, from: startDate, to: endDate)
            filter()
            viewState = .success
        } catch {
            viewState = .error(error.localizedDescription)
            alertItem = AlertItem(
                title: "Не удалось загрузить список транзакций",
                message: error.localizedDescription,
                dismissButton: .default(Text("OK"))
            )
        }
        
        
    }
    
}
