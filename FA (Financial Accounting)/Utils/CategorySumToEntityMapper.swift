//
//  TransactionToEntityMaooer.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 24.07.2025.
//

import PieChart
import Foundation

final class CategorySumToEntityMapper {
    static let shared = CategorySumToEntityMapper()
    
    func map(_ category: CategorySum) -> Entity {
        let decimalValue = category.sum as NSDecimalNumber
        let value = CGFloat(decimalValue.doubleValue)
        let name = category.name
        return Entity(
            value: value,
            label: name
        )
    }
}
