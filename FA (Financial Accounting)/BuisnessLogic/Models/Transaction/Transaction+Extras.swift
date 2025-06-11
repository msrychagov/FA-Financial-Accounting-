//
//  Transaction+Extras.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 11.06.2025.
//

import Foundation
import CoreData

extension Transaction {
    static func parse(jsonObject: Any, in context: NSManagedObjectContext) -> Transaction? {
        guard let dict = jsonObject as? [String: Any] else { return nil }
        
        guard let id = dict["id"] as? String,
              let valueString = dict["value"] as? String,
              let value = Decimal(string: valueString),
              let timestamp = dict["timesTamp"] as? Int,
              let comment = dict["comment"] as? String,
              let hidden = dict["hidden"] as? Bool
        else { return nil }
        
        let request: NSFetchRequest<Transaction>  = Transaction.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        let transaction = (try? context.fetch(request).first) ?? Transaction(context: context)
        
        
        if let account = dict["account"] {
            transaction.account = BankAccount.parse(jsonObject: account, in: context)
        } else {
            return nil
        }
        
        if let category = dict["category"] {
            transaction.category = Category.parse(jsonObject: category, in: context)
        } else {
            return nil
        }
        
        transaction.id = Int64(id)!
        transaction.value = NSDecimalNumber(decimal: value)
        transaction.timestamp = Int64(timestamp)
        transaction.comment = comment
        transaction.hidden = hidden
        
        return transaction
        
    }
    
    var jsonObject: Any {
        let dict: [String: Any] = [
            "id": String(id),
            "account": account?.jsonObject,
            "category": category?.jsonObject,
            "value": value?.stringValue,
            "timestamp": timestamp,
            "comment": comment,
            "hidden": hidden
        ]
        return dict
    }
}
