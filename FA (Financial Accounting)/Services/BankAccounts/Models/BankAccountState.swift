//
//  BankAccountState.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 18.07.2025.
//
import Foundation

struct BankAccountState {
    let id: Int
    let name: String
    let balance: Decimal
    let currency: String
}

struct BankAccountStateDTO: Decodable {
    let id: Int
    let name: String
    let balance: String
    let currency: String
}

extension BankAccountStateDTO: ConverterToBuisnessModel {
    typealias BuisnessModel = BankAccountState
    
    func convertToBuisnessModel() throws -> BankAccountState {
        let decimalBalance = balance.convertToDecimal()
        
        return BankAccountState(id: id, name: name, balance: decimalBalance, currency: currency)
    }
}
