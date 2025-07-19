//
//  TransactionEntity.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 18.07.2025.
//
import Foundation
import SwiftData

@Model
final class TransactionEntity {
    @Attribute(.unique)
    var id: Int
    var accountId: Int
    var accountName: String
    var accountBalance: Decimal
    var accountCurrency: String
    var categoryId: Int
    var categoryName: String
    var categoryEmoji: String
    var categoryIsIncome: Bool
    var amount: Decimal
    var transactionDate: Date
    var createdAt: Date
    var updatedAt: Date
    var comment: String
    
    init(from transaction: Transaction) {
        self.id = transaction.id
        self.accountId = transaction.account.id
        self.accountName = transaction.account.name
        self.accountBalance = transaction.account.balance
        self.accountCurrency = transaction.account.currency
        self.categoryId = transaction.category.id
        self.categoryName = transaction.category.name
        self.categoryEmoji = String(transaction.category.emoji)
        self.categoryIsIncome = transaction.category.direction == .income
        self.amount = transaction.amount
        self.transactionDate = transaction.transactionDate
        self.comment = transaction.comment
        self.createdAt = transaction.createdAt
        self.updatedAt = transaction.updatedAt
    }
    
    func toTransaction() -> Transaction {
        let account = TransactionBankAccount(
            id: accountId,
            name: accountName,
            balance: accountBalance,
            currency: accountCurrency
        )
        
        let category = Category(
            id: categoryId,
            name: categoryName,
            emoji: Character(categoryEmoji),
            direction: categoryIsIncome ? .income : .outcome
        )
        
        return Transaction(
            id: id,
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



