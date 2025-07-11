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
    @State var selectedTransaction: Transaction?
    @State var isShowingAddTransactionView: Bool = false
    
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
        GeometryReader { geo in
            NavigationView {
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
                .overlay(
                    plusButton
                        .padding(.bottom, geo.safeAreaInsets.bottom + 16)
                        .padding(.trailing, 16),
                    alignment: .bottomTrailing
                )
                .ignoresSafeArea(edges: .bottom)
                .task {
                    try? await transactionsListModel.fetch(
                        startDate: startOfToday,
                        endDate: generalEnd
                    )
                }
            }
            .fullScreenCover(item: $selectedTransaction) {_ in
                ManageTransactionView(model: ManageTransactionViewModelImp())
            }
            .accentColor(Constants.ToolBar.tintColor)
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
                Button {
                    selectedTransaction = transaction
                } label: {
                    TransactionCell(transaction: transaction)
                }
                .tint(.primary)
            }
        }
    }
    
    private var plusButton: some View {
        Button {
            isShowingAddTransactionView = true
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.white)
                .padding(20)
        }
        .frame(width: 56, height: 56)
        .background(.accent)
        .clipShape(Circle())
        .fullScreenCover(isPresented: $isShowingAddTransactionView) {
            ManageTransactionView(model: ManageTransactionViewModelImp())
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
