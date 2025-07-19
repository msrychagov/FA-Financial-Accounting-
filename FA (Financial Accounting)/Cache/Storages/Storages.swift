//
//  Storages.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.07.2025.
//

final class Storages {
    let offlineTransactions: OfflineTransactionsStorage
    let unsyncedOperations: UnsyncedTransactionsStorage
    init() throws {
        offlineTransactions = try OfflineTransactionsStorage()
        unsyncedOperations = try UnsyncedTransactionsStorage()
    }
}
