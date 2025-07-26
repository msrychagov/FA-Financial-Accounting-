//
//  AccountView.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.06.2025.
//

import SwiftUI

public struct AccountView: View {
    // MARK: Constants
    private enum Constants {
        enum Balance {
            static let emoji: String = ""
            static let text: String = "Баланс"
        }
        enum Currency {
            static let titleText: String = "Валюта"
            static let titleColor: Color = .black
            static let imageSystemName: String = "chevron.right"
            static let chevronColor: Color = .secondary
        }
        enum ConfirmationDialog {
            static let title: String = "Валюта"
        }
    }
    
    //MARK: Variables
    @State
    var viewModel: AccountModel
    @State
    private var showingCurrencyDialog = false
    
    @State private var isBalanceHidden: Bool = false
    private let segments = ["По дням", "По месяцам"]
    @State private var selectedIndex = 0
    private var selectedHistory: [BalanceOnDate] {
        selectedIndex == 0
        ? viewModel.balanceOnDate
        : viewModel.balanceInMonth
    }
    
    // MARK: Views
    public var body: some View {
        NavigationStack {
            switch viewModel.viewState {
            case .idle, .loading:
                ProgressView("Загрузка данных")
                    .frame(maxWidth: .infinity, alignment: .center)
            case .error(let error):
                Text(error)
            case .success, .errorSaving:
                List {
                    BalanceCell(
                        balance: viewModel.balance,
                        backgroundColor: .accent, isHidden: isBalanceHidden
                    )
                    .listRowSeparator(.hidden)
                    Section {}
                    currencyRow
                    Section {}
                    chart
                        .listRowBackground(Color.clear)
                }
                .background(
                    ShakeDetector {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isBalanceHidden.toggle()
                        }
                    }
                )
                .refreshable {
                    do {
                        try await viewModel.refreshAccount()
                    }
                    catch {
                        print("Не удалось обновить счёт:", error)
                    }
                }
                .tint(.secondAccent)
                .navigationTitle("Мой счёт")
                .toolbar {
                    ToolbarItem {
                        NavigationLink("Редактировать") {
                            EdditingAccountView(
                                viewModel: $viewModel
                            )
                        }
                        .tint(.secondAccent)
                    }
                }
            }
        }
        .task {
            try? await viewModel.transactionsService.syncOperations()
            await viewModel.loadAccount()
            await viewModel.getHistory()
        }
        //        .onChange(of: selectedIndex) { newIndex in
        //            viewModel.period = (newIndex == 0 ? .daily : .monthly)
        //            Task {
        //                await viewModel.getHistory()
        //            }
        //        }
        .alert(item: $viewModel.alertItem) { alert in
            Alert(
                title: Text(alert.title),
                message: Text(alert.message),
                dismissButton: alert.dismissButton
            )
        }
    }
    
    private var currencyRow: some View {
        HStack {
            Text("Валюта")
            Spacer()
            Text(viewModel.currency.rawValue)
        }
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 12).fill(.accent.opacity(0.2)))
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        
    }
    
    private var chart: some View {
        VStack {
            Picker("Выберите сегмент", selection: $selectedIndex) {
                ForEach(0..<segments.count, id: \.self) { idx in
                    Text(segments[idx]).tag(idx)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            AccountHistoryChart(history: selectedHistory)
                .animation(.easeInOut(duration: 0.5), value: selectedIndex)
                .frame(height: 200)
        }
    }
}

