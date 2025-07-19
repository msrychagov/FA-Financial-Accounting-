//
//  CategoriesModel.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 03.07.2025.
//
import Foundation
import Combine
import SwiftUI

@MainActor
final class CategoriesViewModel: ObservableObject {
    private let service: CategoriesService
    @Published var toShowCategories: [Category] = []
    @Published var query: String = ""
    private var cancellables = Set<AnyCancellable>()
    private var categories: [Category] = []
    @Published var viewState: ViewState
    @Published var alertItem: AlertItem?
    
    init(categoriesService: CategoriesService) {
        self.service = categoriesService
        self.viewState = .idle
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
            toShowCategories = categories
        } else {
            // Раскладка
            toShowCategories = categories.filter {
                $0.name.lowercased().levenshteinDistance(
                    to: inputText.lowercased()
                ) <= 2 || $0.name.lowercased().contains(inputText.lowercased())
            }
        }
    }
    
    func byDirectionCategories(_ direction: Direction) -> [Category] {
        return toShowCategories.filter { $0.direction == direction }
    }
    
    func loadCategories() async throws {
        do {
            viewState = .loading
            categories = try await service.fetchAll()
            toShowCategories = categories
            viewState = .success
        } catch {
            viewState = .error(error.localizedDescription)
            alertItem = AlertItem(
                title: "Не удалось загрузить категории",
                message: error.localizedDescription,
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
