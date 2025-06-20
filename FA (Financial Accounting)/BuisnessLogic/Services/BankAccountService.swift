//
//  BankAccountService.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 14.06.2025.
//

final class BankAccountService {
    let bankAccountsService: BankAccountsService = BankAccountsService()
    
    func bankAccount(id: String) async -> BankAccount? {
        let accounts = await bankAccountsService.bankAccounts()
        return accounts.first(where: { $0.id == id })
    }
}
