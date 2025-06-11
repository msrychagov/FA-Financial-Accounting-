//
//  Category+Extras.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 11.06.2025.
//

import Foundation
import CoreData

extension Category {
    var direction: Direction {
        get { isIncome ? .income : .outcome}
        set { isIncome = newValue == .income}
    }
    var emojiChar: Character {
        emoji!.first ?? "❓"
    }
}
