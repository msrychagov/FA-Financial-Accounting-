//
//  Account.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 10.06.2025.
//
import Foundation

struct BankAccountDTO: Codable {
    let id: Int
    let name: String
    let balance: Decimal
    let currency: String
}
