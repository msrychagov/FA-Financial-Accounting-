//
//  FA__Financial_Accounting_Tests.swift
//  FA (Financial Accounting)Tests
//
//  Created by Михаил Рычагов on 10.06.2025.
//

import XCTest
@testable import FA__Financial_Accounting_

final class FA__Financial_Accounting_Tests: XCTestCase {
    var fileCache: TransactionFileCache?
    var formatter: ISO8601DateFormatter?
    var testTransaction: Transaction?
    var testAccount: BankAccount?
    
    override func setUpWithError() throws {
        fileCache = TransactionFileCache()
        formatter = ISO8601DateFormatter()
        formatter!.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let testCategory = Category(id: 1, name: "Зарплата", emoji: "💰", isIncome: .income)
        testAccount = BankAccount(id: "1", name: "Основной счёт", balance: 1000.00, currency: "RUB")
        testTransaction = Transaction(id: 1,
                                      account: testAccount!,
                                      category: testCategory,
                                      amount: 500.00,
                                      transactionDate: formatter!.date(from: "2025-06-13T17:44:11.107Z")!,
                                      comment: "Зарплата за месяц",
                                      createdAt: formatter!.date(from: "2025-06-13T17:44:11.107Z")!,
                                      updatedAt: formatter!.date(from: "2025-06-13T17:44:11.107Z")!)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCategoryParse() {
        let categoryJSON: Any = [
            "id": "1",
            "name": "Зарплата",
            "emoji": "💰",
            "isIncome": "income"
        ]
        let parsedCategory = Category.parse(jsonObject: categoryJSON)
        XCTAssertNotNil(parsedCategory, "parse(jsonObject:) должен вернуть не-nil для корректных данных")
        
        XCTAssertEqual(parsedCategory?.id, 1)
        XCTAssertEqual(parsedCategory?.name, "Зарплата")
        XCTAssertEqual(parsedCategory?.emoji, "💰")
        XCTAssertEqual(parsedCategory?.isIncome, .income)
    }
    
    func testBankAccountParse() {
        let bankAccountJSON: Any = [
            "id": "1",
            "name": "Основной счёт",
            "balance": "1000.00",
            "currency": "RUB"
        ]
        let parsedBankAccount = BankAccount.parse(jsonObject: bankAccountJSON)
        
        XCTAssertNotNil(parsedBankAccount, "parse(jsonObject:) должен вернуть не-nil для корректных данных")
        XCTAssertEqual(parsedBankAccount, testAccount)
    }
    
    func testTransactionParse() {
        let transactionJSON: [String: Any] = [
            "id": "1",
            "account": [
                "id": "1",
                "name": "Основной счёт",
                "balance": "1000.00",
                "currency": "RUB"
            ],
            "category": [
                "id": "1",
                "name": "Зарплата",
                "emoji": "💰",
                "isIncome": "income"
            ],
            "amount": "500.00",
            "transactionDate": "2025-06-13T17:44:11.107Z",
            "comment": "Зарплата за месяц",
            "createdAt": "2025-06-13T17:44:11.107Z",
            "updatedAt": "2025-06-13T17:44:11.107Z"
        ]
        let transaction = Transaction.parse(jsonObject: transactionJSON)
        XCTAssertNotNil(transaction, "Не удалось распарсить транзакцию")
        XCTAssertEqual(transaction?.id, 1)
        XCTAssertEqual(transaction?.account, testAccount)
        XCTAssertEqual(transaction?.category, Category(id: 1, name: "Зарплата", emoji: "💰", isIncome: .income))
        XCTAssertEqual(transaction?.amount, 500.00)
        XCTAssertEqual(transaction?.transactionDate, formatter!.date(from: "2025-06-13T17:44:11.107Z"))
        XCTAssertEqual(transaction?.comment, "Зарплата за месяц")
        XCTAssertEqual(transaction?.createdAt, formatter!.date(from: "2025-06-13T17:44:11.107Z"))
        XCTAssertEqual(transaction?.updatedAt, formatter!.date(from: "2025-06-13T17:44:11.107Z"))
    }
    
    func testSaveFile() {
        let name = "transactions"
        fileCache?.add(testTransaction!)
        try? fileCache?.save(fileName: name)
        
    }
    
    func testLoadFile() {
        let name = "transactions"
        fileCache?.add(testTransaction!)
        try? fileCache?.load(fileName: name)
        
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

