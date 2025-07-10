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
    
    func testCategoryIncorrectIntParse() {
        // Некорректное значение id
        let categoryJSON: Any = [
            "id": "a",
            "name": "Зарплата",
            "emoji": "💰",
            "isIncome": "income"
        ]
        let parsedCategory = Category.parse(jsonObject: categoryJSON)
        XCTAssertNil(parsedCategory)
    }
    
    func testCategoryIncorrectDirectionParse() {
        // Некорректное rawValue для Direction
        let categoryJSON: Any = [
            "id": "22",
            "name": "Зарплата",
            "emoji": "💰",
            "isIncome": "iincome"
        ]
        let parsedCategory = Category.parse(jsonObject: categoryJSON)
        XCTAssertNil(parsedCategory)
    }
    
    func testCategoryIncorrectJSON1Parse() {
        // Отсутствует поле name
        let categoryJSON: Any = [
            "id": "22",
            "emoji": "💰",
            "isIncome": "income"
        ]
        let parsedCategory = Category.parse(jsonObject: categoryJSON)
        XCTAssertNil(parsedCategory)
    }
    
    func testCategoryIncorrectJSON2Parse() {
        // Некорректный ключ(emojji)
        let categoryJSON: Any = [
            "id": "22",
            "name": "Зарплата",
            "emojji": "💰",
            "isIncome": "income"
        ]
        let parsedCategory = Category.parse(jsonObject: categoryJSON)
        XCTAssertNil(parsedCategory)
    }
    
    func testCategoryIncorrectJSON3Parse() {
        // Некорректный JSON
        let categoryJSON: Any = "aaa"
        let parsedCategory = Category.parse(jsonObject: categoryJSON)
        XCTAssertNil(parsedCategory)
    }
    
    func testCategoryEncoding() {
        let testCategory = Category(id: 1, name: "Зарплата", emoji: "💰", isIncome: .income)
        let jsonCategory = testCategory.jsonObject
        let category = Category.parse(jsonObject: jsonCategory)
        XCTAssertEqual(category, testCategory)
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
    
    func testBankAccountIncorrectJSON1Parse() {
        let bankAccountJSON: Any = ""
        let parsedBankAccount = BankAccount.parse(jsonObject: bankAccountJSON)
        
        XCTAssertNil(parsedBankAccount)
    }
    
    func testBankAccountIncorrectJSON2Parse() {
        // Отсутствует поле id
        let bankAccountJSON: Any = [
            "name": "Основной счёт",
            "balance": "1000.00",
            "currency": "RUB"
        ]
        let parsedBankAccount = BankAccount.parse(jsonObject: bankAccountJSON)
        
        XCTAssertNil(parsedBankAccount)
    }
    
    func testBankAccountIncorrectJSON3Parse() {
        // Некорректный ключ(naame)
        let bankAccountJSON: Any = [
            "id": "1",
            "naame": "Основной счёт",
            "balance": "1000.00",
            "currency": "RUB"
        ]
        let parsedBankAccount = BankAccount.parse(jsonObject: bankAccountJSON)
        
        XCTAssertNil(parsedBankAccount)
    }
    
    func testBankAccountIncorrectDecimalParse() {
        // Некорректный ключ(naame)
        let bankAccountJSON: Any = [
            "id": "1a",
            "naame": "Основной счёт",
            "balance": "aaa",
            "currency": "RUB"
        ]
        let parsedBankAccount = BankAccount.parse(jsonObject: bankAccountJSON)
        
        XCTAssertNil(parsedBankAccount)
    }
    
    
    
    func testAccountEncoding() {
        let jsonAccount = testAccount?.jsonObject
        let account = BankAccount.parse(jsonObject: jsonAccount)
        XCTAssertNotNil(account)
        XCTAssertEqual(account, testAccount)
    }
    
    func testTransactionParse() {
        let transactionJSON: Any = [
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
    
    
    func testTransactionBadIncorrectIntParse() {
        // Некорректное значение id
        let transactionJSON: Any = [
            "id": "1mmm",
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
        XCTAssertNil(transaction)
    }
    
    func testTransactionBadIncorrectDecimalParse() {
        // Некорректное значение счета
        let transactionJSON: Any = [
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
            "amount": "mmm",
            "transactionDate": "2025-06-13T17:44:11.107Z",
            "comment": "Зарплата за месяц",
            "createdAt": "2025-06-13T17:44:11.107Z",
            "updatedAt": "2025-06-13T17:44:11.107Z"
        ]
        let transaction = Transaction.parse(jsonObject: transactionJSON)
        XCTAssertNil(transaction)
    }
    
    func testTransactionBadIncorrectAccountParse() {
        // Некорректное значение вложенного типа
        let transactionJSON: Any = [
            "id": "1",
            "account": "mmm",
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
        XCTAssertNil(transaction)
    }
    
    func testTransactionJSONWithoutIdParse() {
        // Отсутствует поле id
        let transactionJSON: Any = [
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
        XCTAssertNil(transaction)
    }
    
    
    
    func testTransactionJSONEncoding() {
        let transactionJSON = testTransaction?.jsonObject
        let transaction = Transaction.parse(jsonObject: transactionJSON!)
        XCTAssertNotNil(transaction)
        XCTAssertEqual(transaction, testTransaction)
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
    
    func testCSVParse() {
        let transaactionStr = "id,accountId,accountName,accountBalance,accountCurrency,categoryId,categoryName,categoryEmoji,categoryIsIncome,amount,transactionDate,comment,createdAt,updatedAt" + "\n" + "1,1,Основной счёт,1000.00,RUB,1,Зарплата,💰,income,500.00,2025-06-13T17:44:11.107Z,Зарплата за месяц,2025-06-13T17:44:11.107Z,2025-06-13T17:44:11.107Z"
        let transaction = Transaction.parse(csv: transaactionStr)
        XCTAssertNotNil(transaction)
        XCTAssertEqual(transaction.first!, testTransaction!)
    }
    
    func testCSVEncode() {
        let transactionCSV = Transaction.toCSV([testTransaction!])
        let transaction = Transaction.parse(csv: transactionCSV)
        XCTAssertNotNil(transaction)
        XCTAssertEqual(transaction.first!, testTransaction!)
        
    }
    
    func testTransactionService() async throws {
        let service = TransactionsService()
        var loadedTransactions = try? await service.transactions()
        loadedTransactions?.sort(by: {$0.amount > $1.amount })
        print(loadedTransactions)
        XCTAssertNotNil(loadedTransactions)
    }
    
    func testDate() async throws {
        let dateFromJSON: String = "2025-06-19T23:42:34.083Z"
        let formattedDateFromJSON: Date = (formatter?.date(from: dateFromJSON))!
        let now = Date()
        let calendar = Calendar.current
        let startOfToday = calendar.date(
            bySettingHour: 3,
            minute: 0,
            second: 0,
            of: now
        )!
        let endOfToday = calendar.date(byAdding: DateComponents(day:1, second: -1), to: startOfToday)!
        let service = TransactionsService()
        
        let transactionsFromService = try await service.fetchTransactions(
            startDate: startOfToday,
            endDate: endOfToday
        )
        
        print(transactionsFromService)
        print(startOfToday)
        print(endOfToday)
        print(formattedDateFromJSON)
        print(startOfToday <= formattedDateFromJSON && endOfToday >= formattedDateFromJSON)
    
    }
    
    func testSorting() async throws {
        var numbers = [3, 1, 4, 2]
        numbers.sort(by: >)
        print(numbers)
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

