//
//  TransactionsServiceMok.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 14.06.2025.
//
import Foundation

final class TransactionsServiceMok {
    let accountsService: BankAccountsServiceMok = BankAccountsServiceMok()
    let categoriesService: CategoriesServiceMok = CategoriesServiceMok()
    var transactionsStorage: [Int:Transaction] = [
            1 : Transaction(id: 1,
                            account: BankAccount(id: "g5ldpb73", name: "Основной счёт", balance: 15000.50, currency: "RUB"),
                            category: Category(id: 2, name: "Зарплата", emoji: "💰", isIncome: .income),
                            amount: 1000.00,
                            transactionDate: "2025-07-11T20:42:34.083Z".convertToDate()!,
                            comment: "Зарплата за месяц",
                            createdAt: "2025-07-12T23:42:34.083Z".convertToDate()!,
                            updatedAt: "2025-06-12T23:42:34.083Z".convertToDate()!),
            2:Transaction(id: 2,
                          account: BankAccount(id: "g5ldpb73", name: "Дополнительный счёт", balance: 1000.00, currency: "USD"),
                          category: Category(id: 1, name: "Одежда", emoji: "👕", isIncome: .outcome),
                          amount: 61.00,
                          transactionDate: "2025-07-11T23:42:34.083Z".convertToDate()!,
                          comment: "Покупка футболки",
                          createdAt: "2025-06-24T23:42:34.083Z".convertToDate()!,
                          updatedAt: "2025-06-24T23:42:34.083Z".convertToDate()!),
            3:Transaction(id: 3,
                          account: BankAccount(id: "g5ldpb73", name: "Основной счёт", balance: 15000.50, currency: "RUB"),
                          category: Category(id: 3, name: "Подработка", emoji: "💰", isIncome: .income),
                          amount: 500.00,
                          transactionDate: "2025-07-12T23:43:34.083Z".convertToDate()!,
                          comment: "Таскал кирпичи",
                          createdAt: "2025-06-13T23:42:34.083Z".convertToDate()!,
                          updatedAt: "2025-06-13T23:42:34.083Z".convertToDate()!),
            4:Transaction(id: 4,
                          account: BankAccount(id: "g5ldpb73", name: "Дополнительный счёт", balance: 1000.00, currency: "USD"),
                          category: Category(id: 1, name: "Одежда", emoji: "👕", isIncome: .outcome),
                          amount: 666.00,
                          transactionDate: "2025-07-09T23:42:34.083Z".convertToDate()!,
                          comment: "Покупка футболки",
                          createdAt: "2025-06-13T23:42:34.083Z".convertToDate()!,
                          updatedAt: "2025-06-13T23:42:34.083Z".convertToDate()!),
            5:Transaction(id: 5,
                          account: BankAccount(id: "g5ldpb73", name: "Дополнительный счёт", balance: 1000.00, currency: "USD"),
                          category: Category(id: 2, name: "На собаку", emoji: "🐕", isIncome: .outcome),
                          amount: 1000.00,
                          transactionDate: "2025-07-10T23:42:34.083Z".convertToDate()!,
                          comment: "Купил корм",
                          createdAt: "2025-06-13T23:42:34.083Z".convertToDate()!,
                          updatedAt: "2025-06-13T23:42:34.083Z".convertToDate()!),
            6:Transaction(id: 6,
                          account: BankAccount(id: "g5ldpb73", name: "Дополнительный счёт", balance: 1000.00, currency: "USD"),
                          category: Category(id: 7, name: "Ремонт", emoji: "🔨", isIncome: .outcome),
                          amount: 30.00,
                          transactionDate: "2025-07-11T23:42:34.083Z".convertToDate()!,
                          comment: "Покрасил стены",
                          createdAt: "2025-06-13T23:42:34.083Z".convertToDate()!,
                          updatedAt: "2025-06-13T23:42:34.083Z".convertToDate()!),
            7:Transaction(id: 7,
                          account: BankAccount(id: "g5ldpb73", name: "Дополнительный счёт", balance: 1000.00, currency: "USD"),
                          category: Category(id: 4, name: "Аптека", emoji: "⛑️", isIncome: .outcome),
                          amount: 30.00,
                          transactionDate: "2025-06-24T23:42:34.083Z".convertToDate()!,
                          comment: "Купил витамины",
                          createdAt: "2025-06-13T23:42:34.083Z".convertToDate()!,
                          updatedAt: "2025-06-13T23:42:34.083Z".convertToDate()!),
            8:Transaction(id: 8,
                          account: BankAccount(id: "g5ldpb73", name: "Дополнительный счёт", balance: 1000.00, currency: "USD"),
                          category: Category(id: 5, name: "На любимую", emoji: "❤️", isIncome: .outcome),
                          amount: 30.00,
                          transactionDate: "2025-07-13T23:42:34.083Z".convertToDate()!,
                          comment: "Купил цветы",
                          createdAt: "2025-06-13T23:42:34.083Z".convertToDate()!,
                          updatedAt: "2025-06-13T23:42:34.083Z".convertToDate()!),
            9:Transaction(id: 9,
                          account: BankAccount(id: "g5ldpb73", name: "Дополнительный счёт", balance: 1000.00, currency: "USD"),
                          category: Category(id: 6, name: "Ставки", emoji: "⚽️", isIncome: .outcome),
                          amount: 50000.00,
                          transactionDate: "2025-07-12T23:42:34.083Z".convertToDate()!,
                          comment: "ЦСКА команда г...",
                          createdAt: "2025-06-13T23:42:34.083Z".convertToDate()!,
                          updatedAt: "2025-06-13T23:42:34.083Z".convertToDate()!),
        ]
    
    func loadTransactions() async throws -> [Int:Transaction] {
        do {
            return transactionsStorage
        } catch {
            throw Errors.TransactionsServiceMok.loadFromServerError
        }
    }
    
    func fetchTransactions(startDate: Date? = startOfToday, endDate: Date? = generalEnd) async throws -> [Transaction] {
        let transactions = transactionsStorage.values
        return transactions.filter {
            $0.transactionDate >= startDate! &&
            $0.transactionDate <= endDate!
        }
    }
    
    func createTransaction(accountId: String, categoryId: Int, amount: Decimal, transactionDate: Date, comment: String) async throws -> Transaction {
        let id = transactionsStorage.values.max{ a, b in a.id < b.id }!.id + 1
        let newTransaction = try await Transaction(id: id,
                                                   account: accountsService.bankAccount(id: accountId)!,
                                                   category: categoriesService.category(id: categoryId)!,
                                                   amount: amount,
                                                   transactionDate: transactionDate,
                                                   comment: comment,
                                                   createdAt: Date.now,
                                                   updatedAt: Date.now)
        transactionsStorage[id] = newTransaction
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
        transactionsStorage[id] = puttedTransaction
        return puttedTransaction
    }
    
    func deleteTransaction(id: Int) async throws {
        var transactions = try await loadTransactions()
        transactions.removeValue(forKey: id)
        transactionsStorage = transactions
    }
    
    // Добавил метод для получения транзакции по id
    func transaction(id: Int) async throws -> Transaction {
        let transactions = try await loadTransactions()
        guard let foundedTransaction = transactions[id] else {
            throw Errors.TransactionsServiceMok.transactionNotFound
        }
        return foundedTransaction
    }
    
}
