//
//  AccountToEntityMaooer.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.07.2025.
//

struct AccountToEntityMapper {
    func map(_ account: TransactionBankAccount) -> AccountEntity {
        AccountEntity(id: account.id, name: account.name, balance: account.balance, currency: account.currency)
    }
}
