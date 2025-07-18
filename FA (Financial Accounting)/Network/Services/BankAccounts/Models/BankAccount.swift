//
//  BankAccountDTO.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 18.07.2025.
//
import Foundation

struct BankAccount {
    let id: Int
    let userId: Int
    let name: String
    let balance: Decimal
    let currency: String
    let createdAt: Date
    let updatedAt: Date
}

struct BankAccountDTO: Decodable {
    let id: Int
    let userId: Int
    let name: String
    let balance: String
    let currency: String
    let createdAt: String
    let updatedAt: String
}

extension BankAccountDTO: ConverterToBuisnessModel {
    typealias BuisnessModel = BankAccount
    
    func convertToBuisnessModel() throws -> BuisnessModel {
        let decimalBalance = balance.convertToDecimal()
        let createdDate = createdAt.convertToDate()
        let updatedDate = updatedAt.convertToDate()
        
        return BuisnessModel(
            id: id,
            userId: userId,
            name: name,
            balance: decimalBalance,
            currency: currency,
            createdAt: createdDate,
            updatedAt: updatedDate)
    }
}
