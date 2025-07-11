//
//  TransactionsService.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 14.06.2025.
//
import Foundation

final class TransactionsService {
    let accountsService: BankAccountsService = BankAccountsService()
    let categoriesService: CategoriesService = CategoriesService()
    private(set) var transactionsToServer: [Int:Transaction] = [:]
    private func transactionsFromServer() async throws-> [Int:Transaction] {
        let transactions: [Int:Transaction] = [
            1 : Transaction(id: 1,
                            account: BankAccount(id: "g5ldpb73", name: "Основной счёт", balance: 15000.50, currency: "RUB"),
                            category: Category(id: 2, name: "Зарплата", emoji: "💰", isIncome: .income),
                            amount: 1000.00,
                            transactionDate: formatter.date(from: "2025-07-11T23:42:34.083Z")!,
                            comment: "Зарплата за месяц",
                            createdAt: formatter.date(from: "2025-06-24T23:42:34.083Z")!,
                            updatedAt: formatter.date(from: "2025-06-24T23:42:34.083Z")!),
            2:Transaction(id: 2,
                          account: BankAccount(id: "g5ldpb73", name: "Дополнительный счёт", balance: 1000.00, currency: "USD"),
                          category: Category(id: 1, name: "Одежда", emoji: "👕", isIncome: .outcome),
                          amount: -30.00,
                          transactionDate: formatter.date(from: "2025-07-11T23:42:34.083Z")!,
                          comment: "Покупка футболки",
                          createdAt: formatter.date(from: "2025-06-24T23:42:34.083Z")!,
                          updatedAt: formatter.date(from: "2025-06-24T23:42:34.083Z")!),
            3:Transaction(id: 3,
                          account: BankAccount(id: "g5ldpb73", name: "Основной счёт", balance: 15000.50, currency: "RUB"),
                          category: Category(id: 3, name: "Подработка", emoji: "💰", isIncome: .income),
                          amount: 500.00,
                          transactionDate: formatter.date(from: "2025-07-11T23:43:34.083Z")!,
                          comment: "Таскал кирпичи",
                          createdAt: formatter.date(from: "2025-06-13T23:42:34.083Z")!,
                          updatedAt: formatter.date(from: "2025-06-13T23:42:34.083Z")!),
            4:Transaction(id: 4,
                          account: BankAccount(id: "g5ldpb73", name: "Дополнительный счёт", balance: 1000.00, currency: "USD"),
                          category: Category(id: 1, name: "Одежда", emoji: "👕", isIncome: .outcome),
                          amount: -30.00,
                          transactionDate: formatter.date(from: "2025-07-11T23:42:34.083Z")!,
                          comment: "Покупка футболки",
                          createdAt: formatter.date(from: "2025-06-13T23:42:34.083Z")!,
                          updatedAt: formatter.date(from: "2025-06-13T23:42:34.083Z")!),
            5:Transaction(id: 5,
                          account: BankAccount(id: "g5ldpb73", name: "Дополнительный счёт", balance: 1000.00, currency: "USD"),
                          category: Category(id: 2, name: "На собаку", emoji: "🐕", isIncome: .outcome),
                          amount: -1000.00,
                          transactionDate: formatter.date(from: "2025-07-11T23:42:34.083Z")!,
                          comment: "Покупка футболки",
                          createdAt: formatter.date(from: "2025-06-13T23:42:34.083Z")!,
                          updatedAt: formatter.date(from: "2025-06-13T23:42:34.083Z")!),
            6:Transaction(id: 6,
                          account: BankAccount(id: "g5ldpb73", name: "Дополнительный счёт", balance: 1000.00, currency: "USD"),
                          category: Category(id: 7, name: "Ремонт", emoji: "🔨", isIncome: .outcome),
                          amount: -30.00,
                          transactionDate: formatter.date(from: "2025-07-11T23:42:34.083Z")!,
                          comment: "Покупка футболки",
                          createdAt: formatter.date(from: "2025-06-13T23:42:34.083Z")!,
                          updatedAt: formatter.date(from: "2025-06-13T23:42:34.083Z")!),
            7:Transaction(id: 7,
                          account: BankAccount(id: "g5ldpb73", name: "Дополнительный счёт", balance: 1000.00, currency: "USD"),
                          category: Category(id: 4, name: "Аптека", emoji: "⛑️", isIncome: .outcome),
                          amount: -30.00,
                          transactionDate: formatter.date(from: "2025-06-24T23:42:34.083Z")!,
                          comment: "Покупка футболки",
                          createdAt: formatter.date(from: "2025-06-13T23:42:34.083Z")!,
                          updatedAt: formatter.date(from: "2025-06-13T23:42:34.083Z")!),
            8:Transaction(id: 8,
                          account: BankAccount(id: "g5ldpb73", name: "Дополнительный счёт", balance: 1000.00, currency: "USD"),
                          category: Category(id: 5, name: "На любимую", emoji: "❤️", isIncome: .outcome),
                          amount: -30.00,
                          transactionDate: formatter.date(from: "2025-01-11T23:42:34.083Z")!,
                          comment: "Покупка футболки",
                          createdAt: formatter.date(from: "2025-06-13T23:42:34.083Z")!,
                          updatedAt: formatter.date(from: "2025-06-13T23:42:34.083Z")!),
            9:Transaction(id: 9,
                          account: BankAccount(id: "g5ldpb73", name: "Дополнительный счёт", balance: 1000.00, currency: "USD"),
                          category: Category(id: 6, name: "Ставки", emoji: "⚽️", isIncome: .outcome),
                          amount: -50000.00,
                          transactionDate: formatter.date(from: "2025-04-11T23:42:34.083Z")!,
                          comment: "Покупка футболки",
                          createdAt: formatter.date(from: "2025-06-13T23:42:34.083Z")!,
                          updatedAt: formatter.date(from: "2025-06-13T23:42:34.083Z")!),
        ]
        
        return transactions
    }
    
    func loadTransactions() async throws -> [Int:Transaction] {
        do {
            let transactions = try await transactionsFromServer()
            return transactions
        } catch {
            throw Errors.TransactionsService.loadFromServerError
        }
    }
    
    func fetchTransactions(startDate: Date? = startOfToday, endDate: Date? = generalEnd) async throws -> [Transaction] {
        let transactions = try await loadTransactions().values
        return transactions.filter {
            $0.transactionDate >= startDate! &&
            $0.transactionDate <= endDate!
        }
    }
    
    func createTransaction(accountId: String, categoryId: Int, amount: Decimal, transactionDate: Date, comment: String) async throws -> Transaction {
        var transactions = try await loadTransactions()
        let id = transactions.values.max{ a, b in a.id < b.id }!.id + 1
        let newTransaction = try await Transaction(id: id,
                                                   account: accountsService.bankAccount(id: accountId)!,
                                                   category: categoriesService.category(id: categoryId)!,
                                                   amount: amount,
                                                   transactionDate: transactionDate,
                                                   comment: comment,
                                                   createdAt: Date.now,
                                                   updatedAt: Date.now)
        transactions[id] = newTransaction
        transactionsToServer = transactions
        return newTransaction
    }
    
    func putTransaction(id: Int, categoryId: Int, amount: Decimal, transactionDate: Date, comment: String) async throws -> Transaction {
        let currentTransaction = try await transaction(id: id)
        let category = try await categoriesService.category(id: categoryId)!
        let puttedTransaction = Transaction(id: id,
                                            account: currentTransaction.account,
                                            category: category,
                                            amount: amount,
                                            transactionDate: transactionDate,
                                            comment: comment,
                                            createdAt: currentTransaction.createdAt,
                                            updatedAt: Date.now)
        transactionsToServer[id] = puttedTransaction
        return puttedTransaction
    }
    
    func deleteTransaction(id: Int) async throws {
        var transactions = try await loadTransactions()
        transactions.removeValue(forKey: id)
        transactionsToServer = transactions
    }
    
    // Добавил метод для получения транзакции по id
    func transaction(id: Int) async throws -> Transaction {
        let transactions = try await loadTransactions()
        guard let foundedTransaction = transactions[id] else {
            throw Errors.TransactionsService.transactionNotFound
        }
        return foundedTransaction
    }
    
}
