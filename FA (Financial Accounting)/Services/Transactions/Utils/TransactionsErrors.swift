//
//  Errors.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 17.07.2025.
//
extension TransactionsRepository {
    enum Errors: Error {
        case emptyTransaction
        case emptyTransactionsList
    }
}
