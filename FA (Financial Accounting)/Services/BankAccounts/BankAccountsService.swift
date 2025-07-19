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
    
    init(repo: BankAccountsRepository = BankAccountsRepository(), storage: SwiftDataAccountsStorage) {
        self.repo = repo
        self.storage = storage
    }
    
    func fetchAll() async throws -> [BankAccount] {
        do {
            let accounts = try await repo.fetchAll()
            try await saveToStorage(accounts)
            return accounts
        } catch {
            return try await storage.fetchAll()
        }
    }
    
    func createAccount(name: String, balance: Decimal, currency: String) async throws -> BankAccount {
        let account = try await repo.createAccount(name: name, balance: balance, currency: currency)
        try await storage.save(account)
        return account
    }
    
    func fetchAccountDetails(id: Int) async throws -> BankAccountDetails {
        try await repo.fetchAccountDetails(id: id)
    }
    
    func updateAccount(id: Int, name: String, currency: String, balance: Decimal) async throws -> BankAccount {
        let account = try await repo.updateAccount(id: id, name: name, balance: balance, currency: currency)
        try await storage.update(account)
        return account
    }
    
    func deleteAccount(id: Int) async throws {
        try await repo.deleteAccount(id: id)
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

extension BankAccountsService {
    func saveToStorage(_ accounts: [BankAccount]) async throws {
        for account in accounts {
            try await storage.save(account)
        }
    }
}
