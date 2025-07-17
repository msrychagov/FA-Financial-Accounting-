//
//  ServicesTests.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 27.06.2025.
//

import XCTest
@testable import FA__Financial_Accounting_

final class TransactionsServiceTests: XCTestCase {
    let transactionsService: TransactionsServiceMok = TransactionsServiceMok()
    let formatter = ISO8601DateFormatter()
    override func setUpWithError() throws {
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    }

    
    func testLoadTransactions() async throws {
        let loadedTransactions = try await transactionsService.loadTransactions()
        XCTAssertEqual(loadedTransactions.count, 9)
    }
    
    func testFetchTransactions() async throws {
        let fetchedTransactions = try await transactionsService.fetchTransactions()
        XCTAssertEqual(fetchedTransactions.count, 6)
    }
    
    func testcreateTransaction() async throws {
        let transaction = try await transactionsService.createTransaction(
            accountId: "g5ldpb73",
            categoryId: 12,
            amount: 250.0,
            transactionDate: formatter.date(from: "2025-07-11T00:00:00.083Z")!,
            comment: "Бонуска в риме"
        )
        let expectedTransaction: Transaction = Transaction(
            id: 10,
            account: BankAccount(
                id: "g5ldpb73",
                name: "Основной счёт",
                balance: 15000.50,
                currency: "RUB"
            ),
            category: Category(
                id: 12,
                name: "Деп",
                emoji: "💰",
                isIncome: false
            ),
            amount: 250.0,
            transactionDate: formatter.date(from: "2025-07-11T00:00:00.083Z")!,
            comment: "Бонуска в риме",
            createdAt: formatter.date(from: "2025-07-11T00:00:00.083Z")!,
            updatedAt: formatter.date(from: "2025-07-11T00:00:00.083Z")!
        )
        
        XCTAssertEqual(transaction.id, expectedTransaction.id)
        XCTAssertEqual(transaction.amount, expectedTransaction.amount)
        XCTAssertEqual(transaction.transactionDate, expectedTransaction.transactionDate)
        XCTAssertEqual(transaction.category, expectedTransaction.category)
        XCTAssertEqual(transaction.account, transaction.account)
        XCTAssertEqual(transaction.comment, expectedTransaction.comment)
        
        XCTAssertEqual(transactionsService.transactionsStorage.count, 10)
    }
    
    func testPutTransaction() async throws {
        let puttedTransaction = try await transactionsService.putTransaction(
            id: 1,
            categoryId: 2,
            amount: 123.45,
            transactionDate: formatter.date(from: "2025-07-11T00:00:00.083Z")!,
            comment: "Test"
        )
        
        XCTAssertEqual(puttedTransaction.id, 1)
        XCTAssertEqual(
            puttedTransaction.category,
            Category(
                id: 2,
                name: "Зарплата",
                emoji: "💰",
                isIncome: true
            )
        )
        XCTAssertEqual(puttedTransaction.amount, 123.45)
        XCTAssertEqual(puttedTransaction.transactionDate, formatter.date(from: "2025-07-11T00:00:00.083Z")!)
        XCTAssertEqual(puttedTransaction.comment, "Test")
        
        XCTAssertEqual(puttedTransaction, transactionsService.transactionsStorage[1])
    }
    
    func testDeleteTransaction() async throws {
        try await transactionsService.deleteTransaction(id: 1)
        XCTAssertNil(transactionsService.transactionsStorage[1])
        XCTAssertEqual(transactionsService.transactionsStorage.count, 8)
    }
}
