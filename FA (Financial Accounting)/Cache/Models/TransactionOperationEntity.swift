//
//  BackupOperationEntity.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 20.07.2025.
//

import SwiftData
import Foundation

@Model
final class TransactionOperationEntity {
    var id: String
    var transactionId: Int
    var type: String
    var transactionData: Data
    
    init(from operation: TransactionsOperation) {
        id = operation.id
        transactionId = operation.transactionId
        type = operation.type.rawValue
        transactionData = try! JSONEncoder().encode(operation.transactionRequest)
    }
    
    
    func toTransactionOperation() -> TransactionsOperation {
        let request = try! JSONDecoder().decode(TransactionRequestBody.self, from: transactionData)
        return TransactionsOperation(id: id, transactionId: transactionId, type: OperationType(rawValue: type)!, transactionRequest: request)
    }
}
