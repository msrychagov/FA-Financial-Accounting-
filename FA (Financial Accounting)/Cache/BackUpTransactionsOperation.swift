//
//  BackUpTransactionsOperation.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 20.07.2025.
//

import Foundation

struct TransactionsOperation {
    var id: String
    var transactionId: Int
    var type: OperationType
    var transactionRequest: TransactionRequestBody
    
    init(transactionId: Int, type: OperationType, transactionRequest: TransactionRequestBody) {
        self.id = UUID().uuidString
        self.transactionId = transactionId
        self.type = type
        self.transactionRequest = transactionRequest
    }
    
    init(id: String, transactionId: Int, type: OperationType, transactionRequest: TransactionRequestBody) {
            self.id = id
            self.transactionId = transactionId
            self.type = type
            self.transactionRequest = transactionRequest
        }
}
