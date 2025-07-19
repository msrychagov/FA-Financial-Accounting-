//
//  SwiftDataBackupAccountOperation.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 20.07.2025.
//

import SwiftData
import Foundation


actor SwiftDataBackupAccountsOperations: BackupOperations {
    
    typealias Operation = AccountOperation
    private let context: ModelContext
    
    var operations: [AccountOperation] {
        get async throws {
            let descriptor = FetchDescriptor<AccountOperationEntity>()
            let models = try context.fetch(descriptor)
            return models.map({ $0.toAccountOperation() })
        }
    }
    
    init(context: ModelContext) {
        self.context = context
    }
    
    
    
    func saveOperation(_ operation: AccountOperation) async throws {
        do {
            let model = AccountOperationEntity(from: operation)
            context.insert(model)
            try context.save()
        } catch {
            throw StorageErrors.Backup.saveOperationError
        }
    }
    
    func removeOpeartion(with id: String) async throws {
        let descripter = FetchDescriptor<AccountOperationEntity>(
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
