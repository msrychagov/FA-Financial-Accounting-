//
//  CreateTransactionModel.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 17.07.2025.
//

import Foundation


struct TransactionRequestBody: Codable {
    var accountId: Int
    var categoryId: Int
    var amount: Decimal
    var transactionDate: String
    var comment: String
}

protocol TransactionRequest: Codable {
    var accountId: Int { get }
    var categoryId: Int { get }
    var amount: Decimal { get }
    var transactionDate: String { get }
    var comment: String { get }
}

struct UpdateTransactionModel: TransactionRequest {
    var accountId: Int

    var categoryId: Int
    
    var amount: Decimal
    
    var transactionDate: String
    
    var comment: String
    
    
}

struct CreateTransactionModel: TransactionRequest {
    var accountId: Int
    
    var categoryId: Int
    
    var amount: Decimal
    
    var transactionDate: String
    
    var comment: String
    
    
}
