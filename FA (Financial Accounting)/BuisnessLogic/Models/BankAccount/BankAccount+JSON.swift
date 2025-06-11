//
//  BankAccount+JSON.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 11.06.2025.
//


import Foundation
import CoreData

extension BankAccount {
    static func parse(jsonObject: Any, in context: NSManagedObjectContext) -> BankAccount? {
        guard let dict = jsonObject as? [String : Any] else { return nil }
        
        guard let id = dict["id"] as? String,
              let name = dict["name"] as? String,
              let currency = dict["currency"] as? String,
              let balance = dict["balance"] as? String else { return nil }
        
        let request: NSFetchRequest<BankAccount> = BankAccount.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        let account = (try? context.fetch(request).first) ?? BankAccount(context: context)
        
        account.id = id
        account.name = name
        account.currency = currency
        account.balance = (Decimal(string: balance) ?? 0.0) as NSDecimalNumber
        
        return account
    }
    
    var jsonObject: Any {
        let dict: [String : Any] = ["id" : id,
                "name" : name,
                "balance" : balance?.stringValue,
                "currency" : currency,
        ]
        
        return dict
    }
}
