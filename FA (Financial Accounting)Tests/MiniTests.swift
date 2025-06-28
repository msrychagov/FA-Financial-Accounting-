//
//  ServicesTests.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 27.06.2025.
//

import XCTest
@testable import FA__Financial_Accounting_

final class MiniTests: XCTestCase {
    override func setUpWithError() throws {
        
    }
    
    func testFromRub() async throws {
        let balance: Decimal = 1000.00
        print(balance * Currency.usd.rateFromRub)
        print(balance * Currency.eur.rateFromRub)
    }
    
    func testToRub() async throws {
        let balance: Decimal = 1000.00
        print(balance * Currency.rub.rateFromUsd)
        print(balance * Currency.rub.rateFromEur)
    }
    
    func testToUSDFromEur() async throws {
        let balance: Decimal = 1000.00
        print(balance * Currency.usd.rateFromEur)
    }
    
    func testToEurFromUsd() async throws {
        let balance: Decimal = 1000.00
        print(balance * Currency.eur.rateFromUsd)
    }
}
