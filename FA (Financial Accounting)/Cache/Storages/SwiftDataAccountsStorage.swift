//
//  SwiftDataAccountsStorage.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 20.07.2025.
//

import SwiftData
import Foundation

actor SwiftDataAccountsStorage {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchAll() async throws -> [BankAccount] {
        let descriptor = FetchDescriptor<AccountEntity>()
        do {
            return try context.fetch(descriptor).map( {$0.toBankAccount() })
        } catch {
            throw StorageErrors.Account.fetchAccountsError
        }
    }
    
    func save(_ account: BankAccount) async throws {
        let accountId = account.id
        let descriptor = FetchDescriptor<AccountEntity>(
            predicate: #Predicate { $0.id == accountId }
        )
        do {
            let model = AccountEntity(from: account)
            let models = try context.fetch(descriptor)
            if let existingModel = models.first {
                context.delete(existingModel)
            }
            context.insert(model)
            try context.save()
        } catch {
            throw StorageErrors.Account.fetchAccountsError
        }
    }
    
    func update(_ account: BankAccount) async throws {
        let accountId  = account.id
        let descriptor = FetchDescriptor<AccountEntity>(
            predicate: #Predicate { $0.id == accountId}
        )
        do {
            let models = try context.fetch(descriptor)
            if let model = models.first {
                model.name = account.name
                model.currency = account.currency
                model .balance = account.balance
                try context.save()
            }
        } catch {
            throw StorageErrors.Account.updateAccountError
        }
    }
    
    func delete(_ account: BankAccount) async throws {
        let accountId  = account.id
        let descriptor = FetchDescriptor<AccountEntity>(
            predicate: #Predicate { $0.id == accountId}
        )
        do {
            let models = try context.fetch(descriptor)
            if let model = models.first {
                context.delete(model)
                try context.save()
            }
        } catch {
            throw StorageErrors.Account.deleteAccountError
        }
    }
    
    func account(for id: Int) async throws -> BankAccount {
        let descriptor = FetchDescriptor<AccountEntity>(
            predicate: #Predicate { $0.id == id }
        )
        let models = try context.fetch(descriptor)
        guard let model = models.first else { throw StorageErrors.Account.getAccountError }
        return model.toBankAccount()
    }
}
