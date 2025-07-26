//
//  BankAccountsServiceTests.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 18.07.2025.
//

import XCTest
@testable import FA__Financial_Accounting_

final class BankAccountsServiceTests: XCTestCase {
    let service = ServiceFactory.shared.createBankAccountsService()
    
    override func setUpWithError() throws {
        
    }
    
    func testFetchAll() async throws {
        let accounts = try await service.fetchAll()
        print(accounts)
    }
    
    func testCreate() async throws {
        let account = try await service.createAccount(name: "Дополнительный счёт", balance: 10000000.15, currency: "RUB")
        print(account)
        print(try await service.fetchAll())
    }
    
    func testFetchDetails() async throws {
        let account = try await service.fetchAccountDetails(id: 113)
        print(account)
    }
    
    func testUpdate() async throws {
        let account = try await service.updateAccount(id: 366, name: "Дополнительный счёт", currency: "USD", balance: 1.00)
        print(account)
    }
    
    func testDelete() async throws {
        try await service.deleteAccount(id: 366)
        print(try await service.fetchAll())
    }
    
    func testHistory() async throws {
        let history = try await service.fetchAccountHistory(id: 113)
        print(history)
    }
    
    func testFetchFirst() async throws {
        let account = try await service.fetchFirst()
        print(account)
    }
}
