//
//  BanlAccountHistory.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 18.07.2025.
//
import Foundation

struct BankAccountHistory {
    let accountId: Int
    let accountName: String
    let currency: String
    let currentBalance: Decimal
    let history: [Change]
}

struct BankAccountHistoryDTO: Decodable {
    let accountId: Int
    let accountName: String
    let currency: String
    let currentBalance: String
    let history: [ChangeDTO]
}

extension BankAccountHistoryDTO: ConverterToBuisnessModel {
    typealias BuisnessModel = BankAccountHistory
    
    func convertToBuisnessModel() throws -> BankAccountHistory {
        let currentBalance = self.currentBalance.convertToDecimal()
        let history = try history.convertToBuisnessModels()
        
        return BankAccountHistory(accountId: accountId, accountName: accountName, currency: currency, currentBalance: currentBalance, history: history)
    }
}
