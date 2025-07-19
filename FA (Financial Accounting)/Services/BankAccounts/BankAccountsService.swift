//
//  BankAccountsService.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 18.07.2025.
//
import Foundation

final class BankAccountsService {
    private let repo: BankAccountsRepository
    private let storage: SwiftDataAccountsStorage
    private let backup: SwiftDataBackupAccountsOperations
    
    init(repo: BankAccountsRepository = BankAccountsRepository(), storage: SwiftDataAccountsStorage, backup: SwiftDataBackupAccountsOperations) {
        self.repo = repo
        self.storage = storage
        self.backup = backup
    }
    
    func fetchAll() async throws -> [BankAccount] {
        do {
            try await syncOperations()
            let accounts = try await repo.fetchAll()
            try await saveToStorage(accounts)
            return try await storage.fetchAll()
        } catch {
            let unsyncedOperations = try await backup.operations
            let local = try await storage.fetchAll()
            let merged = try await apply(unsyncedOperations, to: local)
            return merged
        }
    }
    
    func createAccount(name: String, balance: Decimal, currency: String) async throws {
        do {
            let account = try await repo.createAccount(name: name, balance: balance, currency: currency)
        } catch {
            let localId = try await generateUniqueLocalId()
            let request = BankAccountRequest(name: name, balance: balance, currency: currency)
            let operation = AccountOperation(accountId: localId, type: .create, accountRequest: request)
            try await backup.saveOperation(operation)
        }
    }
    
    func fetchAccountDetails(id: Int) async throws -> BankAccountDetails {
        try await repo.fetchAccountDetails(id: id)
    }
    
    func updateAccount(id: Int, name: String, currency: String, balance: Decimal) async throws -> BankAccount {
        let request = BankAccountRequest(name: name, balance: balance, currency: currency)
        let updating = try await makeAccount(from: request, with: id)
        try await storage.update(updating)
        do {
            let account = try await repo.updateAccount(id: id, name: name, balance: balance, currency: currency)
            return account
        } catch {
            let operation = AccountOperation(accountId: id, type: .update, accountRequest: request)
            try await backup.saveOperation(operation)
            return try await storage.account(for: id)
        }
    }
    
    func deleteAccount(id: Int) async throws {
        do {
            try await repo.deleteAccount(id: id)
        } catch {
            let operation = AccountOperation(accountId: id, type: .delete)
            try await backup.saveOperation(operation)
        }
    }
    
    func fetchAccountHistory(id: Int) async throws -> BankAccountHistory {
        try await repo.fetchAccountHistory(id: id)
    }
    
    func fetchFirst() async throws -> BankAccount {
        guard let account = try await fetchAll().first else {
            throw BankAccountsErrors.accountsNotFound
        }
        
        return account
    }
}

private extension BankAccountsService {
    private func saveToStorage(_ transactions: [BankAccount]) async throws {
        for transaction in transactions {
            try await storage.save(transaction)
        }
    }
    
    func generateUniqueLocalId() async throws -> Int {
        let existingIds = Set(try await storage.fetchAll().map { $0.id })
        var newId: Int
        
        repeat {
            newId = -Int.random(in: 1...Int.max)
        } while existingIds.contains(newId)
        
        return newId
    }
    
    func syncOperations() async throws {
        let unsyncedOperations = try await backup.operations
        for operation in unsyncedOperations {
            let request = operation.accountRequest
            switch operation.type {
            case .create:
                let serverAccount = try await repo.createAccount(name: request!.name, balance: request!.balance, currency: request!.currency)
                try await storage.delete(for: operation.accountId)
                try await storage.save(serverAccount)
            case .update:
                let serverAccount = try await repo.updateAccount(id: operation.accountId, name: request!.name, balance: request!.balance, currency: request!.currency)
                try await storage.update(serverAccount)
            case .delete:
                try await repo.deleteAccount(id: operation.accountId)
                try await storage.delete(for: operation.accountId)
            }
            try await backup.removeOpeartion(with: operation.id)
        }
    }
    
    func makeAccount(from request: BankAccountRequest, with id: Int) async throws -> BankAccount {

        return BankAccount(
            id: id,
            userId: 113,
            name: request.name,
            balance: request.balance,
            currency: request.currency,
            createdAt: Date(),
            updatedAt: Date()
        )
    }
    
    func apply(
        _ operations: [AccountOperation],
        to accounts: [BankAccount]
    ) async throws -> [BankAccount] {
        var dict = Dictionary(uniqueKeysWithValues: accounts.map { ($0.id, $0) })

        for op in operations {
            switch op.type {
            case .create:
                if dict[op.accountId] == nil {
                    let tx = try await makeAccount(from: op.accountRequest!, with: op.accountId)
                    dict[tx.id] = tx
                }

            case .update:
                if let existing = dict[op.accountId] {
                    let request = op.accountRequest!
                    dict[existing.id] = await existing.updating(with: request)
                }

            case .delete:
                dict.removeValue(forKey: op.accountId)
            }
        }
        return Array(dict.values)
    }
}

extension BankAccount {
    func updating(with request: BankAccountRequest) async -> BankAccount {
        BankAccount(
            id: id,
            userId: userId,
            name: request.name,
            balance: request.balance,
            currency: request.currency,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}
