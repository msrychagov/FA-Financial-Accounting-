//
//  TransactionsServiceTests.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 17.07.2025.
//

import XCTest
@testable import FA__Financial_Accounting_

final class TransactionsServiceTests: XCTestCase {
    let storage = try! OfflineTransactionsStorage()
    let backup = try! UnsyncedTransactionsStorage()
    var service: TransactionsService? = nil
    
    override func setUpWithError() throws {
        service = TransactionsService(storage: self.storage, backUp: self.backup)
    }
    
    func testFetchList() async throws {
        let transactions = try await service!.fetchTransactions(accountId: 113)
        print(transactions)
    }
    
    func testFetchDetails() async throws {
        let transaction = try await service!.fetchTransactionDetails(id: 4438)
        print(transaction)
    }
    
    func testCreate() async throws {
        let transaction = try await service!.createTransaction(accountId: 113, categoryId: 5, amount: 50000.50, transactionDate: Date(), comment: "За деп матвею")
        print(transaction)
    }
    
    func testPut() async throws {
        let newtransaction = try await service!.createTransaction(accountId: 113, categoryId: 5, amount: 50000.50, transactionDate: Date(), comment: "За деп матвею")
        let updatedTransaction = try await service!.updateTransaction(id: newtransaction.id, accountId: 113, categoryId: 4, amount: 500.37, transactionDate: Date(), comment: "Жестко заработал")
        print(updatedTransaction)
    }
    
    func testDelete() async throws {
        let transaction = try await service!.createTransaction(accountId: 113, categoryId: 5, amount: 50000.50, transactionDate: Date(), comment: "За деп матвею")
        try await service!.deleteTransaction(id: transaction.id)
    }
}
