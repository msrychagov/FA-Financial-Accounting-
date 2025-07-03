//
//  CategoriesModel.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 03.07.2025.
//
import Foundation
import Combine

final class CategoriesModel: ObservableObject {
    private let service: CategoriesService
    private var allCategories: [Category] = []
    @Published var categories: [Category] = []
    @Published var query: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    init(categoriesService: CategoriesService) {
        self.service = categoriesService
        Task {
            try? await loadCategories()
        }
        $query
//            .removeDuplicates()
//            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.filter(by: text)
            }
            .store(in: &cancellables)
    }
    
    func loadCategories() async throws {
        allCategories = try await service.categories()
        categories = allCategories
    }
    
    func filter(by inputText: String) {
        if inputText.isEmpty {
            categories = allCategories
        } else {
            categories = allCategories.filter {
                $0.name.lowercased().levenshteinDistance(to: inputText.lowercased()) <= 3 || $0.name.lowercased().contains(inputText.lowercased())
            }
        }
    }
}
