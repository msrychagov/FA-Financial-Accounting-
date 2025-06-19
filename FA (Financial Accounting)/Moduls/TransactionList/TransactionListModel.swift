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
    var transactions: [Transaction] = [
        Transaction(id: 1,
                    account: BankAccount(id: "g5ldpb73", name: "Основной счёт", balance: 15000.50, currency: "RUB"),
                    category: Category(id: 2, name: "Зарплата", emoji: "💰", isIncome: .income),
                    amount: 500.00,
                    transactionDate: formatter.date(from: "2025-06-13T23:42:34.083Z")!,
                    comment: "Зарплата за месяц",
                    createdAt: formatter.date(from: "2025-06-13T23:42:34.083Z")!,
                    updatedAt: formatter.date(from: "2025-06-13T23:42:34.083Z")!),
        Transaction(id: 2,
                    account: BankAccount(id: "g5ldpb73", name: "Дополнительный счёт", balance: 1000.00, currency: "USD"),
                    category: Category(id: 1, name: "Одежда", emoji: "🧢", isIncome: .outcome),
                    amount: -30.00,
                    transactionDate: formatter.date(from: "2025-06-13T23:42:34.083Z")!,
                    comment: "Покупка футболки",
                    createdAt: formatter.date(from: "2025-06-13T23:42:34.083Z")!,
                    updatedAt: formatter.date(from: "2025-06-13T23:42:34.083Z")!),
    ]
    
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
        transactions = transactions.filter { $0.category.isIncome == direction }
    }
//    var service: TransactionsService = TransactionsService()
//
//    
//    init() {
//            // опционально: можно сразу подгрузить,
//            // а не через .task вьюхи
//            Task { await loadTransactions() }
//        }
//    
//    func loadTransactions() async {
//        let transactionsFromService = await service.transactions()
//        self.transactions = transactionsFromService
//    }
    
}
