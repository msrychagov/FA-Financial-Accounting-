//
//  TransactionBankAccount.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 18.07.2025.
//

import Foundation

struct TransactionBankAccount: Equatable {
    let id: Int
    let name: String
    let balance: Decimal
    let currency: String
}
