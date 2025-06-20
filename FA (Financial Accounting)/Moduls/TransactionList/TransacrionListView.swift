//
//  TransacrionListView.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.06.2025.
//

import SwiftUI

struct TransactionListView: View {
    // MARK: Properties
    @State var transactionsListModel: TransactionListModel
    
    // MARK: Constants
    enum Constants {
        enum Titles {
            static let income: String = "Доходы сегодня"
            static let outcome: String = "Расходы сегодня"
        }
        enum ToolBar {
            static let clockLabel: Image = Image(systemName: "clock")
            static let tintColor: Color = Color(
                red: 111.0 / 255.0,
                green: 93.0 / 255.0,
                blue: 183.0 / 255.0
            )
        }
        
        enum SumRaw {
            static let title: String = "Всего"
        }
        
        enum TransactionsList {
            static let title: String = "Операции"
        }
    }
    
    // MARK: View
    var body: some View {
        NavigationStack {
            List {
                sum
                transactionsList
            }
            .navigationTitle(
                transactionsListModel.direction == .income ? Constants.Titles.income : Constants.Titles.outcome
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        MyHistoryView(transactionsList: TransactionListModel(direction: transactionsListModel.direction))
                    } label: {
                        Constants.ToolBar.clockLabel
                    }
                    .foregroundColor(Constants.ToolBar.tintColor)
                }
            }
            .toolbarColorScheme(.light, for: .navigationBar)
//            .toolbarBackground(.visible, for: .navigationBar)
//            .toolbarBackground(Color.blue, for: .navigationBar)
//            .tint(Constants.ToolBar.tintColor)
            .task {
                try? await transactionsListModel.fetch(
                    startDate: startOfToday,
                    endDate: generalEnd
                )
            }
        }
    }
    
    // MARK: InsideViews
    private var sum: some View {
        
        Section {
            HStack {
                Menu("Сортировать по") {
                    Menu("Дате") {
                        Button("По возрастанию") {
                            transactionsListModel.sort(by: .date, ascending: true)
                        }
                        Button("По убыванию") {
                            transactionsListModel.sort(by: .date, ascending: false)
                        }
                    }
                    Menu("Сумме") {
                        Button("По возрастанию") {
                            transactionsListModel.sort(by: .amount, ascending: true)
                        }
                        Button("По убыванию") {
                            transactionsListModel.sort(by: .amount, ascending: false)
                        }
                    }
                }
            }
            
            HStack {
                Text(Constants.SumRaw.title)
                Spacer()
                Text("\(formatted(transactionsListModel.sum))")
            }
            
        }
    }
    
    private var transactionsList: some View {
        Section(Constants.TransactionsList.title) {
            ForEach(transactionsListModel.transactions) { transaction in
                NavigationLink {
                    Text("See soon")
                } label: {
                    HStack {
                        Text(transaction.category.emoji)
                        Text(transaction.comment)
                        Spacer()
                        Text("\(formatted(transaction.amount))")
                    }
                    
                }
            }
        }
    }
    
}

#Preview("Income") {
    TransactionListView(
        transactionsListModel: TransactionListModel(direction: .income)
    )
}

#Preview("OutCome") {
    TransactionListView(
        transactionsListModel: TransactionListModel(direction: .outcome)
    )
}
