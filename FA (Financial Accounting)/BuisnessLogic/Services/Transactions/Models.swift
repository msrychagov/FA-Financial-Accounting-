//
//  CreateTransactionModel.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 17.07.2025.
//

import Foundation

protocol ServerTransactionModel: Encodable {
    var accountId: Int { get }
    var categoryId: Int { get }
    var amount: Decimal { get }
    var transactionDate: Date { get }
    var comment: String { get }
}

struct UpdateTransactionModel: ServerTransactionModel, Encodable {
    var accountId: Int
    
    var categoryId: Int
    
    var amount: Decimal
    
    var transactionDate: Date
    
    var comment: String
    
    
}

struct CreateTransactionModel: ServerTransactionModel, Encodable {
    var accountId: Int
    
    var categoryId: Int
    
    var amount: Decimal
    
    var transactionDate: Date
    
    var comment: String
    
    
}
