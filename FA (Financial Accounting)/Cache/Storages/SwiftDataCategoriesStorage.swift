//
//  SwiftDataCategoriesStorage.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 20.07.2025.
//

import SwiftData
import Foundation

actor SwiftDataCategoriesStorage {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchAll() async throws -> [Category] {
        let descriptor = FetchDescriptor<CategoryEntity>()
        do {
            return try context.fetch(descriptor).map({ $0.toCategory() })
        } catch {
            throw StorageErrors.Categories.fetchCategoriesError
        }
    }
    
    func fetch(by direction: Direction) async throws -> [Category] {
        let isIncome = direction == .income
        let descriptor = FetchDescriptor<CategoryEntity>(
            predicate: #Predicate<CategoryEntity> { $0.isIncome == isIncome }
        )
        
        do {
            return try context.fetch(descriptor).map ( {$0.toCategory() })
        } catch {
            throw StorageErrors.Categories.fetchCategoriesError
        }
    }
    
    func replace(_ category: Category) async throws {
        let categoryId = category.id
        let model = CategoryEntity(from: category)
        let descriptor = FetchDescriptor<CategoryEntity> (
            predicate: #Predicate<CategoryEntity> { $0.id == categoryId }
        )
        do {
            let models = try context.fetch(descriptor)
            if let existing = models.first {
                context.delete(existing)
            }
            context.insert(model)
            try context.save()
        } catch {
            throw StorageErrors.Categories.replaceCategoriesError
        }
    }
}
