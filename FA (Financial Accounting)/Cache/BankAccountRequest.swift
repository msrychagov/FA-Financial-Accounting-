//
//  BankAccountRequest.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 21.07.2025.
//
import Foundation

struct BankAccountRequest: Codable {
    var name: String
    var balance: Decimal
    var currency: String
}
