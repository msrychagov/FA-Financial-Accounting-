//
//  TransactionDTO.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 17.07.2025.
//

import Foundation

struct TransactionDTO: Codable {
    let id: Int
    let account: BankAccountDTO
    let category: CategoryDTO
    let amount: String
    let transactionDate: String
    var comment: String
    let createdAt: String
    let updatedAt: String
}

extension TransactionDTO: ConverterToBuisnessModel {
    typealias BuisnessModel = Transaction
    
    func convertToBuisnessModel() throws -> Transaction {
        let account = try self.account.convertToBuisnessModel()
        let category = try self.category.convertToBuisnessModel()
        let amount = self.amount.convertToDecimal()
        let transactionDate = self.transactionDate.convertToDate()
        let createdDate = self.createdAt.convertToDate()
        let updatedDate = self.updatedAt.convertToDate()
        
        return Transaction(
            id: self.id,
            account: account,
            category: category,
            amount: amount,
            transactionDate: transactionDate,
            comment: self.comment,
            createdAt: createdDate,
            updatedAt: updatedDate)
    }
}
