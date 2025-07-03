//
//  CategoriesModel.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 03.07.2025.
//
import Foundation

@Observable
final class CategoriesModel {
    private let service: CategoriesService
    private(set) var categories: [Category] = []
    
    init(categoriesService: CategoriesService) {
        self.service = categoriesService
    }
    
    func loadCategories() async throws {
        categories = try await service.categories()
    }
}
