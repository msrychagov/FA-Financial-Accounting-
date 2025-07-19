//
//  EntityToAccount.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.07.2025.
//

import SwiftData

struct EntityToAccount {
    func map(_ account: AccountEntity) -> TransactionBankAccount {
        TransactionBankAccount(id: account.id, name: account.name, balance: account.balance, currency: account.currency)
    }
}
