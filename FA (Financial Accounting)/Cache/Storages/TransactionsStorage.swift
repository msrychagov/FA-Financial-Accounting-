//
//  TransactionFileCache.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 18.07.2025.
//

protocol TransactionsStorage {
    associatedtype StorageEntity
    
    func fetchAll() async throws -> [StorageEntity]
    func put(id: Int, with value: StorageEntity) async throws
    func delete(id: Int) async throws
    func create(value: StorageEntity) async throws
    func getEntity(by id: Int) async throws -> StorageEntity?
    func saveContext() async throws
}
