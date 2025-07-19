//
//  ServicesFactory.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 20.07.2025.
//

import Foundation

// MARK: - ServiceFactory

final class ServiceFactory {
    
    // MARK: - Singleton
    static let shared = ServiceFactory()
    
    // MARK: - Private Properties
    private let modelContainer: AppModelContainer
//    private let syncStatusManager: SyncStatusManager
    
    // MARK: - Init
    private init() {
        self.modelContainer = AppModelContainer.shared
//        self.syncStatusManager = SyncStatusManager.shared
    }
    
    // MARK: - Methods
    
    func createTransactionsService() -> TransactionsService {        
        return TransactionsService(
            storage: modelContainer.transactionsStorage(),
            accountsStorage: modelContainer.accountsStorage(),
            categoriesStorage: modelContainer.categoriesStorage(),
            backup: modelContainer.backupTransactionsOperations()
        )
    }
    
    func createBankAccountsService() -> BankAccountsService {
        return BankAccountsService(storage: modelContainer.accountsStorage())
    }
    
    func createCategoriesService() -> CategoriesService {
        return CategoriesService(
            categoriesStorage: modelContainer.categoriesStorage()
        )
    }
    
    // MARK: - Private Methods
    
//    func getSyncStatusManager() -> SyncStatusManager {
//        return syncStatusManager
//    }
}
