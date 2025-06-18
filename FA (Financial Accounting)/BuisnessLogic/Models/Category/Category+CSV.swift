//
//  Category+CSV.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 14.06.2025.
//

extension Category {
    var csvRow: String {
        let parts: [String] = [
            String(id),
            name,
            emoji,
            isIncome.rawValue
        ]
        return parts.joined(separator: ",")
    }
    
    static let csvHeader: String = "categoryId,categoryName,categoryEmoji,categoryIsIncome"
}
