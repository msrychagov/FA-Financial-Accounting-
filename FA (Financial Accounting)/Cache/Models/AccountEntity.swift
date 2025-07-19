//
//  AccountEntity.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 18.07.2025.
//

import SwiftData
import Foundation

@Model
final class AccountEntity {
    @Attribute(.unique) var id: Int
    var name: String
    var balance: Decimal
    var currency: String
    
    init(
        id: Int,
        name: String,
        balance: Decimal,
        currency: String
    ) {
        self.id = id
        self.name = name
        self.balance = balance
        self.currency = currency
    }
}
