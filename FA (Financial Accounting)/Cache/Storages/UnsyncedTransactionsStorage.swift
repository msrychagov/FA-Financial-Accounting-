//
//  UnsyncedOperationStorage.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.07.2025.
//
import SwiftData

@MainActor
final class UnsyncedTransactionsStorage: BackUp {
    typealias Entity = UnsyncedOperationEntity
    private let container: ModelContainer
    
    init() throws {
        do {
            self.container = try ModelContainer(for: UnsyncedOperationEntity.self)
        }
    }
    func fetchAll() async throws -> [UnsyncedOperationEntity] {
        let context = container.mainContext
        return try context.fetch(FetchDescriptor<UnsyncedOperationEntity>())
    }
    
    func add(_ entity: UnsyncedOperationEntity) async throws {
        let context = container.mainContext
        context.insert(entity)
    }
    
    func delete(_ entity: UnsyncedOperationEntity) async throws {
        let context = container.mainContext
        context.delete(entity)
    }
    
}
