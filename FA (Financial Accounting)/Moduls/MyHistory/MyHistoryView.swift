//
//  MyHistoryView.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.06.2025.
//
import SwiftUI


struct MyHistoryView: View {
    @State
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
            .toolbarColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        Text("Анализ")
                    } label: {
                        Image(systemName: "newspaper")
                    }
                    .foregroundColor(
                        Color(
                            red: 111.0 / 255.0,
                            green: 93.0 / 255.0,
                            blue: 183.0 / 255.0
                        )
                    )
                }
                
            }
            
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
                    TransactionCell(transaction: transaction)
                    
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
