//
//  TransactionToTransactionEntity.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.07.2025.
//

struct TransactionToEntityMapper {
    func map(_ transaction: Transaction) -> TransactionEntity {
        let account = AccountToEntityMapper().map(transaction.account)
        let category = CategoryToEntityMapper().map(transaction.category)
        
        return TransactionEntity(
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
