//
//  BankAccountDetailsDTO.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 18.07.2025.
//
import Foundation

struct BankAccountDetails {
    let id: Int
    let name: String
    let balance: Decimal
    let currency: String
    let incomeStats: [StatItem]
    let expenseStats: [StatItem]
    let createdAt: Date
    let updatedAt: Date
}

struct BankAccountDetailsDTO: Decodable {
    let id: Int
    let name: String
    let balance: String
    let currency: String
    let incomeStats: [StatItemDTO]
    let expenseStats: [StatItemDTO]
    let createdAt: String
    let updatedAt: String
}

extension BankAccountDetailsDTO: ConverterToBuisnessModel {
    typealias BuisnessModel = BankAccountDetails
    
    func convertToBuisnessModel() throws -> BankAccountDetails {
        let decimalBalance = balance.convertToDecimal()
        let incomeStats = try self.incomeStats.convertToBuisnessModels()
        let expenseStats = try self.expenseStats.convertToBuisnessModels()
        let createdDate = createdAt.convertToDate()
        let updatedDate = updatedAt.convertToDate()
        
        return BankAccountDetails(
            id: id,
            name: name,
            balance: decimalBalance,
            currency: currency,
            incomeStats: incomeStats,
            expenseStats: expenseStats,
            createdAt: createdDate,
            updatedAt: updatedDate
        )
    }
}



