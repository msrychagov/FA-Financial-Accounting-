//
//  BankAccountsService.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 14.06.2025.
//
import Foundation

final class BankAccountsService {
    func bankAccounts() async throws -> [BankAccount] {
        let bankAccounts: [BankAccount] = [
            BankAccount(id: "g5ldpb73", name: "Основной счёт", balance: 15000.50, currency: "RUB"),
            BankAccount(id: "g5ldpb72", name: "Дополнительный счёт", balance: 1000.00, currency: "USD")
        ]
        return bankAccounts
    }
    
    func fetchFirst() async throws -> BankAccount {
        return try await bankAccounts().first!
    }
    
    func putBankAccount(account: BankAccount, newName: String? = nil, newBalance: Decimal? = nil, newCurrency: String? = nil) async throws -> BankAccount {
        let updatedAccount: BankAccount = .init(
            id: account.id,
            name: newName ?? account.name,
            balance: newBalance ?? account.balance,
            currency: newCurrency ?? account.currency
        )
        return updatedAccount
    }
    
    func bankAccount(id: String) async throws -> BankAccount? {
        let accounts = try await bankAccounts()
        return accounts.first(where: { $0.id == id })
    }
}
