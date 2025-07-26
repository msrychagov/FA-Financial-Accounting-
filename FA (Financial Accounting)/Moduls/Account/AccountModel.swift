//
//  AccountModel.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 27.06.2025.
//
import SwiftUI

@Observable
final class AccountModel {
    private(set) var account: BankAccount?
    private(set) var balanceOnDate: [BalanceOnDate] = []
    private(set) var balanceInMonth: [BalanceOnDate] = []
    private(set) var history: [Change] = []
    private let service: BankAccountsService
    var balance: Decimal = 0
    var currency: Currency = .rub
    var viewState: ViewState
    var alertItem: AlertItem?
    let transactionsService: TransactionsService
    
    
    init(service: BankAccountsService = ServiceFactory.shared.createBankAccountsService(),
         transactionsService: TransactionsService = ServiceFactory.shared.createTransactionsService()) {
        self.service = service
        self.transactionsService = transactionsService
        viewState = .idle
    }
    
    func loadAccount() async {
        do {
            viewState = .loading
            try? await transactionsService.syncOperations()
            account = try await service.fetchAll().first
            balance = account!.balance
            viewState = .success
        } catch {
            viewState = .error(error.localizedDescription)
        }
    }
    
    func getHistory() async {
        balanceOnDate = []
        do {
            viewState = .loading
            try await getDailyHistory()
            try await getMonthlyHistory()
            viewState = .success
        } catch {
            viewState = .error(error.localizedDescription)
        }
    }
    
    func getDailyHistory() async throws {
        let dates = Date.dailyDates(from: Date.startBorder, to: Date.endBorder)
        let startBalance = try await balance(on: dates[0])
        balanceOnDate.append(BalanceOnDate(balance: startBalance, date: dates[0]))
        for idx in 1..<dates.count {
            let date = dates[idx]
            let balance = try await balance(on: date) + balanceOnDate[idx - 1].balance
            balanceOnDate.append(BalanceOnDate(balance: balance, date: date))
        }
    }
    
    func getMonthlyHistory() async throws {
        let dates = Date.monthlyDates(from: Date.startForMonthly, to: Date.endBorder)
        let startBalance = try await balance(on: dates[0])
        balanceInMonth.append(BalanceOnDate(balance: startBalance, date: dates[0]))
        for idx in 1..<dates.count {
            let date = dates[idx]
            let balance = try await balance(in: date) + balanceInMonth[idx - 1].balance
            balanceInMonth.append(BalanceOnDate(balance: balance, date: date))
        }
    }
    
    func refreshAccount() async throws {
        account = try await service.updateAccount(id: account!.id, name: account!.name, currency: currency.rawValue, balance: balance)
        balance = account?.balance ?? 0
    }
    
    
    
}

extension AccountModel {
    private func balance(on startTime: Date, calendar: Calendar = .current) async throws -> Decimal {
        guard let endTime = calendar.date(byAdding: DateComponents(day: 1, second: -1), to: startTime) else { return 0.0 }
        let transactions = try await transactionsService.fetchTransactions(accountId: 820, from: startTime, to: endTime)
        let balance = transactions.reduce(0.0) { $0 + ($1.category.direction == .income ? $1.amount : -$1.amount) }
//        let changesOnDate = history.filter { $0.changeTimestamp >= startTime && $0.changeTimestamp <= endTime }.sorted { $0.changeTimestamp < $1.changeTimestamp }
//        print(changesOnDate.map { $0.newState })
//        guard let lastChange = changesOnDate.last else { return 0.0 }
        return balance
    }
    
    private func balance(in startDate: Date, calendar: Calendar = .current) async throws -> Decimal {
        guard let endDate = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDate) else { return 0.0 }
        print(startDate, endDate)
        let transactions = try await transactionsService.fetchTransactions(accountId: 820, from: startDate, to: endDate)
        let balance = transactions.reduce(0.0) { $0 + ($1.category.direction == .income ? $1.amount : -$1.amount) }
        return balance
    }
    
    private func fillZeroBalance() {
        for i in 1..<balanceOnDate.count {
            let balanceOnCurrentDay = balanceOnDate[i].balance
            let balanceOnPrevDay = balanceOnDate[i - 1].balance
            if balanceOnCurrentDay == 0 && balanceOnPrevDay != 0 {
                balanceOnDate[i].balance  = balanceOnPrevDay
            }
        }
        
        var nextNonZeroIdx: Int?
        for i in balanceOnDate.indices.reversed() {
            let balanceOnCurrentDay = balanceOnDate[i].balance
            if balanceOnCurrentDay != 0 {
                nextNonZeroIdx = i
            } else if let next = nextNonZeroIdx {
                let balance = balanceOnDate[next].balance
                let date = balanceOnDate[i].date
                balanceOnDate[i] = BalanceOnDate(balance: balance, date: date)
            }
        }
    }
}
