//
//  UnsyncedOperationStorage.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.07.2025.
//
import SwiftData

final class UnsyncedTransactionsStorage: TransactionsStorage {
    typealias StorageEntity = UnsyncedOperationEntity
    
    private let container: ModelContainer
    
    init() throws {
        do {
            self.container = try ModelContainer(for: UnsyncedOperationEntity.self)
        } catch {
            throw StorageErrors.couldNotCreateUsyncedTransactionsContainer
        }
    }
    func fetchAll() async throws -> [UnsyncedOperationEntity] {
        <#code#>
    }
    
    func put() async throws -> UnsyncedOperationEntity {
        <#code#>
    }
    
    func delete() {
        <#code#>
    }
    
    func create() async throws -> UnsyncedOperationEntity {
        <#code#>
    }
    

}
