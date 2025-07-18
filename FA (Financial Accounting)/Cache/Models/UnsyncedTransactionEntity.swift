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
    @Attribute(.unique) var id: UUID
    
    var type: OperationType
    
    init(id: UUID, type: OperationType) {
        self.id = id
        self.type = type
    }
}
