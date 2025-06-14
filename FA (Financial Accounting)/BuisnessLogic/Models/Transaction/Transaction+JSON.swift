//
//  Transaction+JSON.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 11.06.2025.
//

import Foundation

extension Transaction {
    static func parse(jsonObject: Any) -> Transaction? {
        guard let dict = jsonObject as? [String: Any] else { return nil }
        
        guard let idString = dict["id"] as? String,
              let id = Int(idString),
              let amountString = dict["amount"] as? String,
              let amount = Decimal(string: amountString),
              let account = BankAccount.parse(jsonObject: dict["account"] ?? [:]),
              let category = Category.parse(jsonObject: dict["category"] ?? [:]),
              let transactionDate = formatter.date(from: dict["transactionDate"] as! String),
              let comment = dict["comment"] as? String,
              let createdAt = formatter.date(from: dict["createdAt"] as! String),
              let updatedAt = formatter.date(from: dict["updatedAt"] as! String)
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
