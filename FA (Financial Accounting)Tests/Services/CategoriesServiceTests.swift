//
//  CategoriesServiceTests.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 18.07.2025.
//

import XCTest
@testable import FA__Financial_Accounting_

final class CategoriesServiceTests: XCTestCase {
    let service = CategoriesService()
    
    override func setUpWithError() throws {
        
    }
    
    func testFetchAll() async throws {
        let categories = try await service.fetchAll()
        print(categories)
    }
    
    func testFetchIncome() async throws {
        let categories = try await service.fetchTypeList(direction: .income)
        print(categories.map { $0.direction })
    }
    
    func testFetchOutcome() async throws {
        let categories = try await service.fetchTypeList(direction: .outcome)
        print(categories.map { $0.direction })
    }
}
