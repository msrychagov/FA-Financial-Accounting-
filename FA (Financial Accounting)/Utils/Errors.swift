//
//  Errors.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 11.07.2025.
//

enum Errors {
    enum TransactionsService: Swift.Error {
        case transactionNotFound
        case loadFromServerError
    }
}
