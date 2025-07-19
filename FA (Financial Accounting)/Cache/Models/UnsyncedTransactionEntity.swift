//
//  UnsyncedOperation.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.07.2025.
//

import SwiftData
import Foundation

@Model
final class UnsyncedOperationEntity {
    @Relationship
    var transaction: TransactionEntity
    var type: String
    var date: Date
    
    init(transaction: TransactionEntity, type: String, date: Date) {
        self.transaction = transaction
        self.type = type
        self.date = date
    }
}
