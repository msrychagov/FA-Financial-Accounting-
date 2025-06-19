//
//  TransacrionListView.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.06.2025.
//

import SwiftUI

struct TransactionListView: View {
    
    // MARK: Properties
    @StateObject
    var transactionListModel: TransactionListModel
    
    
    // MARK: Constants
    enum Constants {
        enum Titles {
            static let income: String = "Доходы"
            static let outcome: String = "Расходы"
        }
        enum ToolBar {
            static let trailingLabel: Image = Image(systemName: "clock")
            static let trailintTintColor: Color = .black
        }
        
        enum SumRaw {
            static let title: String = "Всего"
            static let cornerRadius: CGFloat = 12
        }
        
        enum TransactionsList {
            static let title: String = "Операции"
        }
    }
    
    // MARK: Lifecycle
    init (direction: Direction) {
        _transactionListModel = StateObject(wrappedValue: TransactionListModel(direction: direction)
                                            )
    }
    
    var body: some View {
        NavigationStack {
            List {
                sum
                transactionsList
            }
            .navigationTitle(
                transactionListModel.direction == .income ? Constants.Titles.income : Constants.Titles.outcome
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        MyHistoryView()
                    } label: {
                        Constants.ToolBar.trailingLabel
                            .tint(Constants.ToolBar.trailintTintColor)
                    }
                }
            }
        }
    }
    
    // MARK: InsideViews
    private var sum: some View {
        Section {
            HStack {
                Text(Constants.SumRaw.title)
                Spacer()
                Text("\(formatted(transactionListModel.sum))")
            }
            .cornerRadius(Constants.SumRaw.cornerRadius)
        }
    }
    
    private var transactionsList: some View {
        Section(Constants.TransactionsList.title) {
            ForEach(transactionListModel.transactions) { transaction in
                NavigationLink {
                    IncomeView()
                } label: {
                    HStack {
                        Text(transaction.comment)
                        Spacer()
                        Text("\(formatted(transaction.amount))")
                    }
                    
                }
            }
        }
    }
    
    // MARK: Methods
    private func formatted(_ value: Decimal)-> String {
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.groupingSeparator = " " // неправый пробел
        fmt.maximumFractionDigits = 0
        return (fmt.string(from: NSDecimalNumber(decimal: value)) ?? "0") + " ₽"
    }
}

#Preview("Income") {
    TransactionListView(direction: .income)
}

#Preview("OutCome") {
    TransactionListView(direction: .outcome)
}
