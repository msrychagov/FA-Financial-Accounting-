//
//  BankAccount+CSV.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 14.06.2025.
//
import Foundation

extension BankAccount {
    var csvRow: String {
        let parts: [String] = [
            String(id),
            name,
            NSDecimalNumber(decimal: balance).stringValue,
            currency
        ]
        return parts.joined(separator: ",")
    }
    
    static let csvHeader: String = "accountId,accountName,accountBalance,accountCurrency"
}
