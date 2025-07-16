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
              let account = BankAccount.parse(jsonObject: dict["account"] ?? [:]),
              let category = Category.parse(jsonObject: dict["category"] ?? [:]),
              let comment = dict["comment"] as? String
        else { return nil }
        
        

        let transaction = Transaction(id: id, account: account, category: category, amount: amount, transactionDate: transactionDate, comment: comment, createdAt: createdAt, updatedAt: updatedAt)
        
        return transaction
        
    }
    
    var jsonObject: Any {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let dict: Any = [
            "id": String(id),
            "account": account.jsonObject,
            "category": category.jsonObject,
            "amount": NSDecimalNumber(decimal: amount).stringValue,
            "transactionDate": formatter.string(from: transactionDate),
            "comment": comment,
            "createdAt": formatter.string(from: createdAt),
            "updatedAt": formatter.string(from: updatedAt)
        ]
        return dict
    }
}
