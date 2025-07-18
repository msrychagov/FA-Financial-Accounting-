//
//  ManageTransactionViewModel.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 11.07.2025.
//

import Observation
import SwiftUI

protocol ManageTransactionViewModel {
    var viewState: ViewState { get }
    var mode: Mode { get }
    var transactionId: Int? { get }
    var categories: [Category] { get }
    var viewData: TransactionViewData? { get }
    var alertItem: AlertItem? { get set }
    var direction: Direction { get }
    func loadTransaction() async throws
    func loadCategories() async throws
    func createTransaction(selectedCategory: String, sum: String, comment: String, date: Date, time: Date) async throws
    func putTransaction(selectedCategory: String, sum: String, comment: String, date: Date, time: Date) async throws
    func deleteTransaction() async throws
    func mapToViewData(transaction: Transaction) -> TransactionViewData?
}

@Observable
final class ManageTransactionViewModelImp:  ManageTransactionViewModel {
    
    var transactionId: Int?
    var viewState: ViewState
    var alertItem: AlertItem?
    let direction: Direction
    let mode: Mode
    private(set) var categories: [Category] = []
    private(set) var viewData: TransactionViewData?
    private let transactionsService: TransactionsService
    private let categoriesService: CategoriesService
    private let accountsService: BankAccountsService
    
    init(
        viewState: ViewState = .idle,
        transactionsService: TransactionsService = TransactionsService(),
        categoriesService: CategoriesService = CategoriesService(),
        accountsService: BankAccountsService = BankAccountsService(),
        mode: Mode,
        transactionId: Int? = nil,
        direction: Direction
    ) {
        self.viewState = viewState
        self.transactionsService = transactionsService
        self.categoriesService = categoriesService
        self.mode = mode
        self.transactionId = transactionId
        self.accountsService = accountsService
        self.direction = direction
    }
    
    func validateFields(selectedCategory: String, sum: String, comment: String) -> Bool {
        guard
            selectedCategory != "Выберите категорию",
            !sum.isEmpty,
            !comment.isEmpty
        else {
            alertItem = AlertItem(
                title: "Неверный ввод",
                message: "Пожалуйста, заполните все поля.",
                dismissButton: .default(Text("OK"))
            )
            return false
        }
        return true
    }
    
    @MainActor
    func createTransaction(selectedCategory: String, sum: String, comment: String, date: Date, time: Date) async throws {
        if validateFields(selectedCategory: selectedCategory, sum: sum, comment: comment) {
            viewState = .loading
            do {
                let accountId = try await accountsService.fetchFirst().id
                let category = categories.filter { $0.name == selectedCategory }
                let categoryId = category[0].id
                let newDate: Date = combineDate(date, withTime: time)
                _ = try await transactionsService.createTransaction(accountId: accountId, categoryId: categoryId, amount: sum, transactionDate: newDate, comment: comment)
                viewState = .success
            } catch {
                viewState = .error(error.localizedDescription)
                        alertItem = AlertItem(
                            title: "Не удалось создать транзакцию",
                            message: error.localizedDescription,
                            dismissButton: .default(Text("OK"))
                        )
            }
        } else {
            viewState = .errorSaving
        }
    }
    
    @MainActor
    func deleteTransaction() async throws {
        viewState = .loading
        do {
            try await transactionsService.deleteTransaction(id: transactionId!)
        } catch {
            viewState = .error(error.localizedDescription)
            alertItem = AlertItem(
                title: "Не удалось удалить транзакцию",
                message: error.localizedDescription,
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    @MainActor
    func putTransaction(selectedCategory: String, sum: String, comment: String, date: Date, time: Date) async throws {
        if validateFields(selectedCategory: selectedCategory, sum: sum, comment: comment) {
            viewState = .loading
            do {
                let account = try await accountsService.fetchFirst()
                let accountId = account.id
                let category = categories.filter { $0.name == selectedCategory }
                let categoryId = category[0].id
                let newDate = combineDate(date, withTime: time)
                _ = try await transactionsService.updateTransaction(id: transactionId!, accountId: accountId, categoryId: categoryId, amount: sum.convertToDecimal(), transactionDate: newDate, comment: comment)
                viewState = .success
            } catch {
                viewState = .error(error.localizedDescription)
                alertItem = AlertItem(
                    title: "Не удалось обновить транзакцию",
                    message: error.localizedDescription,
                    dismissButton: .default(Text("OK"))
                )
            }
        } else {
            viewState = .errorSaving
        }
    }
    
    @MainActor
    func loadTransaction() async throws {
        viewState = .loading
        do {
            let transaction = try await transactionsService.fetchTransactionDetails(id: transactionId!)
            viewData = mapToViewData(transaction: transaction)
            viewState = .success
        } catch {
            viewState = .error(error.localizedDescription)
            alertItem = AlertItem(
                title: "Не удалось получить детали транзакции",
                message: error.localizedDescription,
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    @MainActor
    func loadCategories() async throws {
        viewState = .loading
        do {
            categories = try await categoriesService.fetchAll()
            categories = categories.filter { $0.direction == direction }
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
