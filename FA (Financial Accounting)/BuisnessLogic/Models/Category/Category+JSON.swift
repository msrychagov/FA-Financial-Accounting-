//
//  Category+JSON.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 11.06.2025.
//

import Foundation
import CoreData

extension Category {
    static func parse(jsonObject: Any) -> Category? {
        guard let dict = jsonObject as? [String: Any] else { return nil }
        
        guard let emoji = dict["emoji"] as? String,
              let name = dict["name"] as? String,
              let id = dict["id"] as? String,
              let isIncome = dict["isIncome"] as? String
        else { return nil }

        let cat = Category(id: id, name: name, emoji: emoji, isIncome: Direction(rawValue: isIncome)!)
        
        return cat
              
    }
    
    var jsonObject: Any {
        var dict: [String: Any] = [
            "emoji" : emoji,
            "name" : name,
            "id" : id,
            "isIncome" : isIncome.rawValue
        ]
        return dict
    }
}


