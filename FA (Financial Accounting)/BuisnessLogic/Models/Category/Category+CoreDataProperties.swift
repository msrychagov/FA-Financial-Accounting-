//
//  Category+CoreDataProperties.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 10.06.2025.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var emoji: String?
    @NSManaged public var isIncome: Bool
    @NSManaged public var transactions: Transaction?

}

extension Category : Identifiable {

}
