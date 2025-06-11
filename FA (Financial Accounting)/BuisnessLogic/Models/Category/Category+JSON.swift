//
//  Category+JSON.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 11.06.2025.
//

import Foundation
import CoreData

extension Category {
    static func parse(jsonObject: Any, in context: NSManagedObjectContext) -> Category? {
        guard let dict = jsonObject as? [String: Any] else { return nil }
        
        guard let emoji = dict["emoji"] as? String,
              let name = dict["name"] as? String,
              let id = dict["id"] as? Int,
              let isIncome = dict["isIncome"] as? String
        else { return nil }
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        let cat = (try? context.fetch(request).first) ?? Category(context: context)

        cat.id = Int64(id)
        cat.name = name
        cat.emoji = emoji
        cat.direction = Direction(rawValue: isIncome)!
        
        
        return cat
              
    }
    
    var jsonObject: Any {
        var dict: [String: Any] = [
            "emoji" : emoji,
            "name" : name,
            "id" : id,
            "IsIncome" : isIncome
        ]
        return dict
    }
}
