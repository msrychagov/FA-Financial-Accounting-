//
//  ServicesTests.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 27.06.2025.
//

import XCTest
@testable import FA__Financial_Accounting_

final class ServicesTests: XCTestCase {
    let transactionsService: TransactionsService = TransactionsService()
    let accountsService: BankAccountsService = BankAccountsService()
    let categoriesService: CategoriesService = CategoriesService()
    override func setUpWithError() throws {
        
    }
    
    func testAccountsService() async throws {
        let account = try? await accountsService.fetchFirst()
        print(account)
    }
}
