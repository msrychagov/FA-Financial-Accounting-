//
//  Categories.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 17.07.2025.
//

final class CategoriesService {
    private let repo: CategoriesRepository
    private let categoriesStorage: SwiftDataCategoriesStorage
    
    init(repo: CategoriesRepository = CategoriesRepository(), categoriesStorage: SwiftDataCategoriesStorage) {
        self.repo = repo
        self.categoriesStorage = categoriesStorage
    }
    
    func fetchAll() async throws -> [Category] {
        do {
            let categories = try await repo.fetchAll()
            try await saveToStorage(categories)
            return categories
        } catch {
            return try await categoriesStorage.fetchAll()
        }
    }
    
    func fetchTypeList(direction: Direction) async throws -> [Category] {
        do {
            let categories = try await repo.fetchTypeList(direction: direction)
            try await saveToStorage(categories)
            return categories
        } catch {
            return try await categoriesStorage.fetch(by: direction)
        }
    }
}

extension CategoriesService {
    private func saveToStorage(_ categories: [Category]) async throws {
        for category in categories {
            try await categoriesStorage.replace(category)
        }
    }
}
