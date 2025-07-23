//
//  SwiftDataBackupTransactionsOperation.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 20.07.2025.
//

import SwiftData
import Foundation

protocol BackupOperations {
    associatedtype Operation
    func saveOperation(_ operation: Operation) async throws
    func removeOpeartion(with id: String) async throws
}

actor SwiftDataBackupTransactionsOperations: BackupOperations {
    typealias Operation = TransactionsOperation
    private let context: ModelContext
    
    var operations: [TransactionsOperation] {
        get async throws {
            let descriptor = FetchDescriptor<TransactionOperationEntity>()
            let models = try context.fetch(descriptor)
            return models.map({ $0.toTransactionOperation() })
        }
    }
    
    init(context: ModelContext) {
        self.context = context
    }
    
    
    
    func saveOperation(_ operation: TransactionsOperation) async throws {
        do {
            let model = TransactionOperationEntity(from: operation)
            context.insert(model)
            try context.save()
        } catch {
            throw StorageErrors.Backup.saveOperationError
        }
    }
    
    func removeOpeartion(with id: String) async throws {
        let descripter = FetchDescriptor<TransactionOperationEntity>(
            predicate: #Predicate { $0.id == id }
        )
        do {
            let models = try context.fetch(descripter)
            for model in models {
                context.delete(model)
            }
            try context.save()
        } catch {
            throw StorageErrors.Backup.deleteOperationError
        }
    }
    
    
}
