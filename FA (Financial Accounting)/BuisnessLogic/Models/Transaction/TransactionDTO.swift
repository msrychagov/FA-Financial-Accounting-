//
//  Transaction.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 10.06.2025.
//

import Foundation

struct TransactionDTO: Codable {
    let id: Int
    let account: BankAccountDTO
    let category: CategoryDTO
    let amount: Decimal
    let transactionDate: Date
    let comment: String
    let createdAt: Date
    let updatedAt: Date
}
