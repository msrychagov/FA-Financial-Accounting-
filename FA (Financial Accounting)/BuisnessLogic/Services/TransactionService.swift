//
//  TransactionService.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 14.06.2025.
//


final class TransactionService {
    let transactionService: TransactionsService = TransactionsService()
    
    func transaction(id: Int) async -> Transaction? {
        let transactions = await transactionService.transactions()
        return transactions.first(where: { $0.id == id })
    }
}
