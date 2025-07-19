//
//  SwiftDataTransactionsStorage.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.07.2025.
//

import SwiftData
import Foundation

@MainActor
final class OfflineTransactionsStorage: TransactionsStorage {
    typealias StorageEntity = TransactionEntity
    
    private let container: ModelContainer
    
    nonisolated
    init() throws {
        do {
            self.container = try ModelContainer(for: TransactionEntity.self, CategoryEntity.self, AccountEntity.self)
        } catch {
            throw StorageErrors.couldNotCreateTransactionsContainer
        }
    }
    
    func fetchAll() async throws -> [TransactionEntity] {
        try container.mainContext.fetch(FetchDescriptor<TransactionEntity>())
    }
    
    func put(id: Int, with value: TransactionEntity) async throws {
        guard let transaction = try await getEntity(by: id) else {
            throw StorageErrors.entityNotFound
        }
        transaction.category = value.category
        transaction.amount = value.amount
        transaction.transactionDate = value.transactionDate
        transaction.comment = value.comment
        transaction.updatedAt = Date.now
        try await saveContext()
    }
    
    func delete(id: Int) async throws {
        guard let transaction = try await getEntity(by: id) else {
            throw StorageErrors.entityNotFound
        }
        try await saveContext()
    }
    
    func create(value: TransactionEntity) async throws {
        let context = container.mainContext
        context.insert(value)
        try await saveContext()
    }
    
    func getEntity(by id: Int) async throws -> TransactionEntity? {
        let context = container.mainContext
        return try context.fetch(FetchDescriptor<TransactionEntity>()).filter({ $0.id == id }).first
    }
    
    func saveContext() async throws {
        let context = container.mainContext
        do {
            try context.save()
        } catch {
            throw StorageErrors.couldNotSaveContext
        }
    }
    
    func fetchAllMapped() async throws -> [Transaction] {
        let entities = try container.mainContext.fetch(
          FetchDescriptor<TransactionEntity>()
        )
        return entities.map(EntityToTransaction().map)
      }
}
