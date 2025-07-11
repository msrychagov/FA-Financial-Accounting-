//
//  AnalysisViewModel.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 10.07.2025.
//
import Foundation

final class AnalysisViewModel {
    private let transactionsService: TransactionsService
    private(set) var categories: [Category] = []
    private(set) var transactions: [Transaction] = []
    let direction: Direction
    
    init(service: TransactionsService, direction: Direction) {
        self.transactionsService = service
        self.direction = direction
    }
    
    func loadData(startDate: Date, endDate: Date) async throws {
        let allTransactions = try await transactionsService.fetchTransactions(startDate: startDate, endDate: endDate)
        transactions = allTransactions.filter { $0.category.isIncome == self.direction }
        let categoriesSet = Set(transactions.map { $0.category })
        categories = Array(categoriesSet)
    }
    
    private func sum(for category: Category) -> Decimal {
        let decimalSum = transactions.reduce(into: Decimal(0)) { result, transaction in
            if transaction.category.id == category.id {
                result += transaction.amount
            }
        }
        return decimalSum
    }
    
    private func sumAll() -> Decimal {
        let decimalSum = transactions.reduce(into: Decimal(0)) { result, transaction in
            result += transaction.amount
        }
        return decimalSum
    }
    
    private func percent(for category: Category) -> Decimal {
        return sum(for: category) / sumAll() * 100
    }
}

extension AnalysisViewModel {
    func stringPercent(for category: Category) -> String {
        let decimalPercent = percent(for: category)
        return (makeFormatter().string(from: NSDecimalNumber(decimal: decimalPercent)) ?? "") + "%"
    }
    
    func stringSum(for category: Category) -> String {
        let decimalSum = sum(for: category)
        return (makeFormatter().string(from: NSDecimalNumber(decimal: decimalSum)) ?? "") + " ₽"
    }
    
    func stringSumAll() -> String {
        let decimalSumAll = sumAll()
        return (makeFormatter().string(from: NSDecimalNumber(decimal: decimalSumAll)) ?? "") + " ₽"
    }
    
    private func makeFormatter(for locale: Locale = .current) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.usesGroupingSeparator = false
        formatter.locale = locale
        return formatter
    }
}
