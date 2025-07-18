//
//  SwiftDataTransactionsStorage.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.07.2025.
//

import SwiftData

final class OfflineTransactionsStorage: TransactionsStorage {
    typealias StorageEntity = TransactionEntity
    
    private let container: ModelContainer
    
    init() throws {
        do {
            self.container = try ModelContainer(for: TransactionEntity.self, CategoryEntity.self, AccountEntity.self)
        } catch {
            throw StorageErrors.couldNotCreateTransactionsContainer
        }
    }
    func fetchAll() async throws -> [TransactionEntity] {
        <#code#>
    }
    
    func put() async throws -> TransactionEntity {
        <#code#>
    }
    
    func delete() {
        <#code#>
    }
    
    func create() async throws -> TransactionEntity {
        <#code#>
    }
    
}
