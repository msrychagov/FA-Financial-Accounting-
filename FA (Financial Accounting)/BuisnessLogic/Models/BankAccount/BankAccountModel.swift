//
//  Account.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 10.06.2025.
//
import Foundation

struct BankAccount: Equatable, Codable {
    let id: String
    let name: String
    var balance: Decimal
    var currency: String
}
