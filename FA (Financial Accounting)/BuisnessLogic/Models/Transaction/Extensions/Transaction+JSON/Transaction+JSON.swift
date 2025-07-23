//
//  Transaction+JSON.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 11.06.2025.
//

import Foundation

extension Transaction {
    static func parse(jsonObject: Any) throws -> Transaction? {
        guard let dict = jsonObject as? [String: Any] else {
            throw Errors.ConvertFromJson.incorrectObject
        }
        
        let transactionDate = try dict.date(from: "transactionDate")
        let createdAt = try dict.date(from: "createdAt")
        let updatedAt = try dict.date(from: "updatedAt")
        
        guard let idString = dict["id"] as? String,
              let id = Int(idString),
              let amountString = dict["amount"] as? String,
              let amount = Decimal(string: amountString),
              let accountDict = dict["account"] as? [String: Any],
              let category = Category.parse(jsonObject: dict["category"] ?? [:]),
              let comment = dict["comment"] as? String
        else { return nil }
        
        guard let accountId = accountDict["id"] as? Int,
              let accountName = accountDict["name"] as? String,
              let accountBalanceString = accountDict["balance"] as? String,
              let accountCurrency = accountDict["currency"] as? String else { return nil }
        
        let account = TransactionBankAccount(id: accountId, name: accountName, balance: accountBalanceString.convertToDecimal(), currency: accountCurrency)
        let transaction = Transaction(id: id, account: account, category: category, amount: amount, transactionDate: transactionDate, comment: comment, createdAt: createdAt, updatedAt: updatedAt)
        
        return transaction
        
    }
    
    var jsonObject: Any {
        let dict: Any = [
            "id": id,
            "account": ["id": account.id, "name": account.name, "balance": account.balance.toString(), "currency": account.currency],
            "category": category.jsonObject,
            "amount": NSDecimalNumber(decimal: amount).stringValue,
            "transactionDate": transactionDate.toString(),
            "comment": comment,
            "createdAt": createdAt.toString(),
            "updatedAt": updatedAt.toString()
        ]
        return dict
    }
}
