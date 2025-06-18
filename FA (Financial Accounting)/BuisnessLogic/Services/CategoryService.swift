//
//  CategoryService.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 14.06.2025.
//

final class CategoryService {
    let categoriesService: CategoriesService = CategoriesService()
    
    func category(id: Int) async -> Category? {
        let categories = await categoriesService.categories()
        return categories.first(where: { $0.id == id })
    }
}
