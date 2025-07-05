//
//  CategoriesModel.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 03.07.2025.
//
import Foundation
import Combine

final class CategoriesViewModel: ObservableObject {
    private let service: CategoriesService
    @Published var toShowCategories: [Category] = []
    @Published var query: String = ""
    private var cancellables = Set<AnyCancellable>()
    
    init(categoriesService: CategoriesService) {
        self.service = categoriesService
        $query
//            .removeDuplicates()
//            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.filterBySearching(text)
            }
            .store(in: &cancellables)
    }
    
    func filterBySearching(_ inputText: String) {
        if inputText.isEmpty {
            toShowCategories = service.categories
        } else {
            // Раскладка
            toShowCategories = service.categories.filter {
                $0.name.lowercased().levenshteinDistance(
                    to: inputText.lowercased()
                ) <= 3 || $0.name.lowercased().contains(inputText.lowercased())
            }
        }
    }
    
    func byDirectionCategories(_ direction: Direction) -> [Category] {
        return toShowCategories.filter { $0.isIncome == direction }
    }
}
