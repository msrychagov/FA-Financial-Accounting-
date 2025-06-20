//
//  MyHistoryView.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.06.2025.
//
import SwiftUI


struct MyHistoryView: View {
    @Bindable
    var transactionsList: TransactionListModel
    @State
    var startDate: Date = startHistory
    @State
    var endDate: Date = generalEnd
    var body: some View {
        NavigationStack {
            List {
                criterias
                transactionsListSection
            }
            .navigationTitle("Моя история")
            .task {
                try? await transactionsList.fetch(
                    startDate: startDate,
                    endDate: endDate
                )
            }
            .onChange(of: [startDate, endDate]) {_ in
                Task {
                    try? await transactionsList.fetch(
                        startDate: startDate,
                        endDate: endDate
                    )
                }
            }
        }
    }
    
    var criterias: some View {
        Section {
            DateView(
                border: .start,
                mainDate: $startDate,
                otherDate: $endDate
            )
            DateView(
                border: .end,
                mainDate: $endDate,
                otherDate: $startDate
            )
            sum
        }
    }
    
    private var transactionsListSection: some View {
        Section("Операции") {
            ForEach(transactionsList.transactions) { transaction in
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
    
    
    
    var sum: some View {
        HStack {
            Text("Сумма")
            Spacer()
            Text("\(formatted(transactionsList.sum))")
        }
    }
}


#Preview("Income") {
    MyHistoryView(
        transactionsList: TransactionListModel(direction: .income)
    )
}

//#Preview("OutCome") {
//    MyHistoryView(transactionsList: TransactionListModel(direction: .outcome))
//}
