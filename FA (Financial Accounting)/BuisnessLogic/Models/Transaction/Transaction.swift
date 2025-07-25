//
//  Transaction.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 10.06.2025.
//

import Foundation

struct Transaction: Equatable, Identifiable {
    let id: Int
    let account: TransactionBankAccount
    let category: Category
    let amount: Decimal
    let transactionDate: Date
    var comment: String
    let createdAt: Date
    let updatedAt: Date
}
