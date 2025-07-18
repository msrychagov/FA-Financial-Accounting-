//
//  TransactionBankAccountDTO.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 18.07.2025.
//

struct TransactionBankAccountDTO: Decodable {
    let id: Int
    let name: String
    let balance: String
    let currency: String
}

extension TransactionBankAccountDTO: ConverterToBuisnessModel {
    typealias BuisnessModel = TransactionBankAccount
    
    func convertToBuisnessModel() throws -> BuisnessModel {
        let decimalBalance = balance.convertToDecimal()
        
        return TransactionBankAccount(id: id, name: name, balance: decimalBalance, currency: currency)
    }
}
