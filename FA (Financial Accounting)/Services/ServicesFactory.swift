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
    
    // MARK: - Init
    private init() {
        self.modelContainer = AppModelContainer.shared
    }
    
    // MARK: - Methods
    
    func createTransactionsService() -> TransactionsService {        
        return TransactionsService(
            storage: modelContainer.transactionsStorage(),
            accountsStorage: modelContainer.accountsStorage(),
            categoriesStorage: modelContainer.categoriesStorage(),
            backup: modelContainer.backupTransactionsOperations(),
            accountsService: createBankAccountsService()
        )
    }
    
    func createBankAccountsService() -> BankAccountsService {
        return BankAccountsService(storage: modelContainer.accountsStorage(), backup: modelContainer.backupAccountsOperations())
    }
    
    func createCategoriesService() -> CategoriesService {
        return CategoriesService(
            categoriesStorage: modelContainer.categoriesStorage()
        )
    }
}
