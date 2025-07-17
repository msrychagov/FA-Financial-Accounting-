//
//  BankAccount+JSON.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 11.06.2025.
//


import Foundation
import CoreData

extension BankAccount {
    static func parse(jsonObject: Any) -> BankAccount? {
        guard let dict = jsonObject as? [String : Any] else { return nil }
        
        guard let id = dict["id"] as? Int,
              let name = dict["name"] as? String,
              let currency = dict["currency"] as? String,
              let balance = dict["balance"] as? String else { return nil }
        
        let account = BankAccount(id: id, name: name, balance: Decimal(string: balance)!, currency: currency)
        
        return account
    }
    
    var jsonObject: Any {
        let dict: Any = [
            "id" : id,
            "name" : name,
            "balance" : NSDecimalNumber(decimal: balance).stringValue,
            "currency" : currency,
        ]
        
        return dict
    }
}
