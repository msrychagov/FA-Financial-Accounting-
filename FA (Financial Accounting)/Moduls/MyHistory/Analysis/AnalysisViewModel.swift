//
//  AnalysisViewModel.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 10.07.2025.
//
import Foundation

final class AnalysisViewModel {
    private let transactionsService: TransactionsService
    private(set) var transactions: [Transaction] = []
    let direction: Direction
    
    init(service: TransactionsService, direction: Direction) {
        self.transactionsService = service
        self.direction = direction
    }
    
    @MainActor
    func loadData(startDate: Date, endDate: Date) async throws {
        let allTransactions = try await transactionsService.fetchTransactions(startDate: startDate, endDate: endDate)
        transactions = allTransactions.filter { $0.category.isIncome == self.direction }
    }
    
    @MainActor
    func sort(by sortingType: SortingType) {
        switch sortingType {
        case .date:
            transactions.sort { $0.transactionDate > $1.transactionDate }
        case .sum:
            transactions.sort { $0.amount > $1.amount }
        }
    }
    
    private func sumAll() -> Decimal {
        let decimalSum = transactions.reduce(into: Decimal(0)) { result, transaction in
            result += transaction.amount
        }
        return decimalSum
    }
    
    private func percent(for transaction:
                         Transaction) -> Decimal {
        return transaction.amount / sumAll() * 100
    }
}

extension AnalysisViewModel {
    func stringPercent(for transaction: Transaction) -> String {
        let decimalPercent = percent(for: transaction)
        return (makeFormatter().string(from: NSDecimalNumber(decimal: decimalPercent)) ?? "") + "%"
    }
    
    func stringSum(for transaction: Transaction) -> String {
        let decimalSum = transaction.amount
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
