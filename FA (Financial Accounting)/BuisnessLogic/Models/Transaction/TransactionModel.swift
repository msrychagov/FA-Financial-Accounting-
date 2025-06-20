//
//  Transaction.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 10.06.2025.
//

import Foundation

struct Transaction: Equatable {
    let id: Int
    let account: BankAccount
    let category: Category
    let amount: Decimal
    let transactionDate: Date
    let comment: String
    let createdAt: Date
    let updatedAt: Date
}
