//
//  BankAccountsService.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 18.07.2025.
//
import Foundation

final class BankAccountsService {
    private let repo: BankAccountsRepository
    
    init(repo: BankAccountsRepository = BankAccountsRepository()) {
        self.repo = repo
    }
    
    func fetchAll() async throws -> [BankAccount] {
        try await repo.fetchAll()
    }
    
    func createAccount(name: String, balance: Decimal, currency: String) async throws -> BankAccount {
        try await repo.createAccount(name: name, balance: balance, currency: currency)
    }
    
    func fetchAccountDetails(id: Int) async throws -> BankAccountDetails {
        try await repo.fetchAccountDetails(id: id)
    }
    
    func updateAccount(id: Int, name: String, currency: String, balance: Decimal) async throws -> BankAccount {
        try await repo.updateAccount(id: id, name: name, balance: balance, currency: currency)
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
