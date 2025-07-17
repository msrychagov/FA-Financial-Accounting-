//
//  TransactionDTO.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 17.07.2025.
//

import Foundation

struct TransactionDTO: Codable {
    let id: Int
    let account: BankAccountDTO
    let category: CategoryDTO
    let amount: String
    let transactionDate: String
    var comment: String
    let createdAt: String
    let updatedAt: String
}

struct CreateTransactionDTO: Decodable {
    let id: Int
    let accountId: Int
    let categoryId: Int
    let amount: String
    let transactionDate: String
    let comment: String
    let createdAt: String
    let updatedAt: String
}
