//
//  CreateTransactionDTO.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 17.07.2025.
//

struct CreateTransactionDTO: Decodable {
    let id: Int
    let accountId: Int
    let categoryId: Int
    let amount: String
    let transactionDate: String
    let comment: String
    let createdAt: String
    let updatedAt: String
}

// TODO: Преобразовать в Transaction
extension CreateTransactionDTO: ConverterToBuisnessModel {
    typealias BuisnessModel = Transaction
    
    func convertToBuisnessModel() throws -> Transaction {
        let amount = self.amount.convertToDecimal()
        let transactionDate = self.transactionDate.convertToDate()
        let createdAt = self.createdAt.convertToDate()
        let updatedAt = self.updatedAt.convertToDate()
        let account = TransactionBankAccount(id: 1, name: "Основной счёт", balance: 100000.00, currency: "RUB")
        let category = Category(id: 1, name: "Зарплата", emoji: "💰", direction: .income)
        return Transaction(
            id: self.id,
            account: account,
            category: category,
            amount: amount,
            transactionDate: transactionDate,
            comment: comment,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
    
}
