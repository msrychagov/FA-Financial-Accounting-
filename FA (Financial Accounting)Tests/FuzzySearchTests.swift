//
//  FuzzySearchTests.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 03.07.2025.
//


import XCTest
@testable import FA__Financial_Accounting_

final class FuzzySearchTests: XCTestCase {
    override func setUpWithError() throws {
        
    }
    
    func testLevensteinDistance() {
        XCTAssertEqual("hello".levenshteinDistance(to: "helo"), 1)
    }
}
