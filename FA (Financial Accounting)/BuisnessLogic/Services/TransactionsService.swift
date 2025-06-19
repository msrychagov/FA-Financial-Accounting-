//
//  TransactionsService.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 14.06.2025.
//
import Foundation

final class TransactionsService {
    static var id: Int = 0
    let accountsService: BankAccountsService = BankAccountsService()
    let categoriesService: CategoriesService = CategoriesService()
    func transactions() async throws-> [Transaction] {
        let transactions = [
            Transaction(id: 1,
                        account: BankAccount(id: "g5ldpb73", name: "Основной счёт", balance: 15000.50, currency: "RUB"),
                        category: Category(id: 2, name: "Зарплата", emoji: "💰", isIncome: .income),
                        amount: 500.00,
                        transactionDate: formatter.date(from: "2025-06-19T23:42:34.083Z")!,
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
        
        return transactions
    }
    
    func fetchTransactions(startDate: Date? = Date.now, endDate: Date? = Date.now) async throws -> [Transaction] {
        let transactions = try await transactions()
        return transactions.filter {
            $0.transactionDate >= startDate! &&
            $0.transactionDate <= endDate!
        }
    }
    
    func createTransaction(accountId: String, categoryId: Int, amount: Decimal, transactionDate: Date, comment: String) async throws -> Transaction {
        TransactionsService.id += 1
        return try await Transaction(id: TransactionsService.id,
                           account: accountsService.bankAccount(id: accountId)!,
                           category: categoriesService.category(id: categoryId)!,
                           amount: amount,
                           transactionDate: transactionDate,
                           comment: comment,
                           createdAt: Date.now,
                           updatedAt: Date.now)
    }
    
    func putTransaction(id: Int, accountId: String, categoryId: Int, amount: Decimal, transactionDate: Date, comment: String) async throws -> Transaction? {
        guard let currentTransaction = try await transaction(id: id),
              let account = try await accountsService.bankAccount(id: accountId),
              let category = try await categoriesService.category(id: categoryId)
        else { return nil }
        return Transaction(id: id,
                           account: account,
                           category: category,
                           amount: amount,
                           transactionDate: transactionDate,
                           comment: comment,
                           createdAt: currentTransaction.createdAt,
                           updatedAt: Date.now)
    }
    
    func deleteTransaction(id: Int) async throws -> [Transaction]{
        var transactions = try await transactions()
        transactions.removeAll { $0.id == id }
        return transactions
    }
    
    // Добавил метод для получения транзакции по id
    func transaction(id: Int) async throws -> Transaction? {
        let transactions = try await transactions()
        return transactions.first(where: { $0.id == id })
    }
    
}
