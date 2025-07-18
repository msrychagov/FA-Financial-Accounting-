//
//  TransactionFileCache.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 18.07.2025.
//

protocol TransactionsStorage {
    associatedtype StorageEntity
    
    func fetchAll() async throws -> [StorageEntity]
    func put() async throws -> StorageEntity
    func delete()
    func create() async throws -> StorageEntity
}
