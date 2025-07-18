//
//  Categories.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 17.07.2025.
//

final class CategoriesService {
    private let repo: CategoriesRepository
    
    init(repo: CategoriesRepository = CategoriesRepository()) {
        self.repo = repo
    }
    
    func fetchAll() async throws -> [Category] {
        try await repo.fetchAll()
    }
    
    func fetchTypeList(direction: Direction) async throws -> [Category] {
        try await repo.fetchTypeList(direction: direction)
    }
}
