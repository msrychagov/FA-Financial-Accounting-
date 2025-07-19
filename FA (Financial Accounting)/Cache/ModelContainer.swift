//
//  ModelContainer.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.07.2025.
//

import Foundation
import SwiftData

// MARK: - ModelContainer

final class AppModelContainer {
    
    // MARK: - Singleton
    static let shared = AppModelContainer()
    
    // MARK: - Private Properties
    private let modelContainer: ModelContainer
    
    // MARK: - Init
    private init() {
        let schema = Schema([
            TransactionEntity.self,
            AccountEntity.self,
            CategoryEntity.self
        ])
        
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )
        
        do {
            self.modelContainer = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    // MARK: - Methods
    
    func modelContext() -> ModelContext {
        return ModelContext(modelContainer)
    }
    
    func getModelContainer() -> ModelContainer {
        return modelContainer
    }
    
    func transactionsStorage() -> SwiftDataTransactionsStorage {
        return SwiftDataTransactionsStorage(modelContext: modelContext())
    }
    
    func categoriesStorage() -> SwiftDataCategoriesStorage {
        return SwiftDataCategoriesStorage(context: modelContext())
    }
    
    func accountsStorage() -> SwiftDataAccountsStorage {
        return SwiftDataAccountsStorage(context: modelContext())
    }

}
