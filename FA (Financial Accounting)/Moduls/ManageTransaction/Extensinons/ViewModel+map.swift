//
//  ViewModel+map.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 11.07.2025.
//
import Foundation

extension ManageTransactionViewModelImp {
    func mapToViewData(transaction: Transaction) -> TransactionViewData? {
        let categoryName = transaction.category.name
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.current
        let amountString = formatter
            .string(from: transaction.amount as NSDecimalNumber)
            ?? "\(transaction.amount)"

        let date = transaction.transactionDate
        let comment = transaction.comment
        
        return TransactionViewData(
            categoryName: categoryName,
            amount: amountString,
            date: date,
            comment: comment
        )
    }
    
}
