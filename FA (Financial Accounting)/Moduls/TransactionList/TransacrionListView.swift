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
            static let tintColor: Color = Color(red: 0.111, green: 0.093, blue: 0.183)
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
                        MyHistoryView(transactionsList: transactionsListModel)
                    } label: {
                        Constants.ToolBar.clockLabel
                    }
                    
                }
                
            }
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
