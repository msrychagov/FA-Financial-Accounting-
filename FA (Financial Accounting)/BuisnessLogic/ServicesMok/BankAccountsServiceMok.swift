//
//  BankAccountsServiceMok.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 14.06.2025.
//
import Foundation

final class BankAccountsServiceMok {
    func bankAccounts() async throws -> [TransactionBankAccount] {
        let bankAccounts: [TransactionBankAccount] = [
            TransactionBankAccount(id: 1, name: "Основной счёт", balance: 15000.50, currency: "RUB"),
            TransactionBankAccount(id: 2, name: "Дополнительный счёт", balance: 1000.00, currency: "USD")
        ]
        return bankAccounts
    }
    
    func featchFirst() async throws -> TransactionBankAccount {
        return try await bankAccounts().first!
    }
    
    func putBankAccount(account: TransactionBankAccount, newName: String? = nil, newBalance: Decimal? = nil, newCurrency: String? = nil) async throws -> TransactionBankAccount {
        let updatedAccount: TransactionBankAccount = .init(
            id: account.id,
            name: newName ?? account.name,
            balance: newBalance ?? account.balance,
            currency: newCurrency ?? account.currency
        )
        return updatedAccount
    }
    
    // Аналогично CategoriesServiceMok
    func bankAccount(id: Int) async throws -> TransactionBankAccount? {
        let accounts = try await bankAccounts()
        return accounts.first(where: { $0.id == id })
    }
}
