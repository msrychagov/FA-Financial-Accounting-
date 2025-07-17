//
//  BankAccountDTO.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 17.07.2025.
//

import Foundation

struct BankAccountDTO: Codable {
    let id: Int
    let name: String
    var balance: String
    var currency: String
}


extension BankAccountDTO: ConverterToBuisnessModel {
    typealias BuisnessModel = BankAccount
    
    func convertToBuisnessModel() throws -> BankAccount {
        let decimalBalance = self.balance.convertToDecimal()
        
        return BankAccount(id: id, name: name, balance: decimalBalance, currency: currency)
    }
    
    
}
