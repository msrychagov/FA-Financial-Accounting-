//
//  EntityToTransaction.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.07.2025.
//

struct EntityToTransaction {
    func map(_ transaction: TransactionEntity) -> Transaction {
        let account = EntityToAccount().map(transaction.account)
        let category = EntityToCategory().map(transaction.category)
        
        return Transaction(
            id: transaction.id,
            account: account,
            category: category,
            amount: transaction.amount,
            transactionDate: transaction.transactionDate,
            comment: transaction.comment,
            createdAt: transaction.createdAt,
            updatedAt: transaction.updatedAt
        )
    }
}
