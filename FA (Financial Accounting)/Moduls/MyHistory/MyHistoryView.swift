//
//  MyHistoryView.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.06.2025.
//
import SwiftUI


struct MyHistoryView: View {
    @State
    var showingAnalysis = false
    @State
    var transactionsList: TransactionListModel
    @State
    var startDate: Date = Date.startBorder
    @State
    var endDate: Date = Date.endBorder
    @State
    var activeSheet: ActiveSheet?
    
    var body: some View {
        List {
            criterias
            transactionsListSection
        }
        .navigationTitle("Моя история")
        //            .toolbarColorScheme(.dark)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    AnalysisViewControllerRepresentable(startDate: startDate, endDate: endDate, direction: transactionsList.direction)
                        .navigationTitle("Анализ")
                        .navigationBarTitleDisplayMode(.large)
                } label: {
                    Image(systemName: "newspaper")
                }
                .foregroundColor(.secondAccent)
            }
            
        }
        .task { @MainActor in
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
        
        .fullScreenCover(item: $activeSheet, onDismiss: {
            Task {
                try? await transactionsList.fetch(
                    startDate: Date.startOfToday,
                    endDate: Date.endBorder
                )
            }
        }) {sheet in
            switch sheet {
            case .create:
                ManageTransactionView(
                    viewModel: ManageTransactionViewModelImp(
                        mode: .create,
                        direction: transactionsList.direction
                    ),
                    activeSheet: $activeSheet
                )
            case .edit(let transaction):
                ManageTransactionView(
                    viewModel: ManageTransactionViewModelImp(
                        mode: .put,
                        transactionId: transaction.id,
                        direction: transactionsList.direction
                    ),
                    activeSheet: $activeSheet
                )
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
                Button {
                    activeSheet = .edit(transaction)
                } label: {
                    TransactionCell(transaction: transaction)
                }
                .tint(.primary)
            }
        }
    }
    
    
    
    var sum: some View {
        HStack {
            Text("Сумма")
            Spacer()
            Text(transactionsList.sum.toString())
        }
    }
}


//#Preview("Income") {
//    MyHistoryView(
//        transactionsList: TransactionListModel(direction: .income)
//    )
//}

//#Preview("OutCome") {
//    MyHistoryView(transactionsList: TransactionListModel(direction: .outcome))
//}
