//
//  SwiftDataTransactionsStorage.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.07.2025.
//

import SwiftData
import Foundation

actor SwiftDataTransactionsStorage {
    private let context: ModelContext
    
    var transactions: [Transaction] {
        get async throws {
            let descriptor = FetchDescriptor<TransactionEntity>()
            
            do {
                let models = try context.fetch(descriptor)
                return models.map { $0.toTransaction() }
            } catch {
                throw StorageErrors.Transactions.transactionsStorageError
            }
        }
    }
    
    init(modelContext: ModelContext) {
        self.context = modelContext
    }
    
    func fetch(from startDate: Date, to endDate: Date) async throws -> [Transaction] {
        let descriptor = FetchDescriptor<TransactionEntity>(
            predicate: #Predicate<TransactionEntity> { $0.transactionDate >= startDate && $0.transactionDate <= endDate }
        )
        
        do {
            let models = try context.fetch(descriptor)
            return models.map( { $0.toTransaction() })
        } catch {
            throw StorageErrors.Transactions.fetchError
        }
    }
    
    func update(_ transaction: Transaction) async throws {
        let transactionId = transaction.id
        let descriptor = FetchDescriptor<TransactionEntity>(
            predicate: #Predicate<TransactionEntity> { $0.id == transactionId }
        )
        
        do {
            let models = try context.fetch(descriptor)
            guard let model = models.first else {
                throw StorageErrors.Transactions.transactionNotFound
            }
            
            model.accountId = transaction.account.id
            model.accountName = transaction.account.name
            model.accountBalance = transaction.account.balance
            model.accountCurrency = transaction.account.currency
            model.categoryId = transaction.category.id
            model.categoryName = transaction.category.name
            model.categoryEmoji = String(transaction.category.emoji)
            model.categoryIsIncome = transaction.category.direction == .income
            model.amount = transaction.amount
            model.transactionDate = transaction.transactionDate
            model.comment = transaction.comment
            try context.save()
        } catch {
            throw StorageErrors.Transactions.updateTransactionError
        }
    }
    
    func delete(_ transaction: Transaction) async throws {
        let model = TransactionEntity(from: transaction)
        context.delete(model)
        try context.save()
    }
    
    func save(_ transaction: Transaction) async throws {
        let transactionTd = transaction.id
        let model = TransactionEntity(from: transaction)
        let descriptor = FetchDescriptor<TransactionEntity>(
            predicate: #Predicate { $0.id == transactionTd }
        )
        do {
            let models = try context.fetch(descriptor)
            if let existingModel = models.first {
                context.delete(existingModel)
            }
            context.insert(model)
            try context.save()
        } catch {
            throw StorageErrors.Transactions.saveContextError
        }
    }

}
