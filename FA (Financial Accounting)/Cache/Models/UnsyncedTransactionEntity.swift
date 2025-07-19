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
    var type: OperationType
    var date: Date
    
    init(id: Int, type: OperationType, date: Date) {
        self.id = id
        self.type = type
        self.date = date
    }
}
