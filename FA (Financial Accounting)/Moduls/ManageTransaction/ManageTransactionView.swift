//
//  ManageTransactionView.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 11.07.2025.
//

import SwiftUI

struct ManageTransactionView: View {
    @State var viewModel: ManageTransactionViewModel
    @Binding var activeSheet: ActiveSheet?
    @State private var selectedCategory: String = "Выберите категорию"
    @State private var date: Date = Date.startBorder
    @State private var time: Date = Date()
    @State private var isSelectedCategory: Bool = true
    @State private var comment: String = ""
    @State private var sum: String = ""
    @State private var didLoad = false
    var body: some View {
        NavigationView {
            switch viewModel.viewState {
            case .idle, .loading:
                ProgressView("Загрузка данных")
                    .frame(maxWidth: .infinity, alignment: .center)
            case .error(let error):
                Text(error)
            case .success, .errorSaving:
                List {
                    mainSection
                    if viewModel.mode == .put {
                        deleteSection
                    }
                }
                .navigationTitle("Мои расходы")
                .toolbar { toolBar }
                .accentColor(.secondAccent)
            }
        }
        .alert(item: $viewModel.alertItem) { alert in
                    Alert(
                        title: Text(alert.title),
                        message: Text(alert.message),
                        dismissButton: alert.dismissButton
                    )
                }
        .task {
            guard !didLoad else { return }
            didLoad = true
            try? await viewModel.loadCategories()
            if viewModel.mode == .put {
                try? await viewModel.loadTransaction()
                selectedCategory = (viewModel.viewData?.categoryName)!
                date = viewModel.viewData!.date
                time = viewModel.viewData!.date
                comment = viewModel.viewData!.comment
                sum = viewModel.viewData!.amount
            }
        }
    }
    
    @ToolbarContentBuilder
    private var toolBar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            if viewModel.mode == .create {
                toolBarButton(action: .create)
            } else {
                toolBarButton(action: .save)
            }
        }
        ToolbarItem(placement: .topBarLeading) {
            toolBarButton(action: .cancel)
        }
    }
    
    private var mainSection: some View {
        Section {
            categoryRow
            sumRow
            dateRow
            timeRow
            commentRow
        }
    }
    
    private var deleteSection: some View {
        Section {
            HStack() {
                Button("Удалить") {
                    Task {
                        try await viewModel.deleteTransaction()
                        dismissSheet()
                    }
                }
                .tint(.red)
            }
        }
    }
    
    private var categoryRow: some View {
        HStack {
            Text("Статья")
            Spacer()
            Menu {
                ForEach(viewModel.categories) { category in
                    Button(category.name) {
                        selectedCategory = category.name
                    }
                }
            } label: {
                HStack {
                    Text(selectedCategory)
                }
            }
        }
    }
    
    private var sumRow: some View {
        HStack {
            Text("Сумма")
            Spacer()
            NumericTextField(textValue: $sum)
            Text("₽")
        }
    }
    
    private var dateRow: some View {
        DateCell(mainTime: $date, otherTime: $time, mode: viewModel.mode, type: .date)
    }
    
    private var timeRow: some View {
        DateCell(mainTime: $time, otherTime: $date, mode: viewModel.mode, type: .time)
    }
    
    private var commentRow: some View {
        HStack {
            TextField("Комментарий...", text: $comment)
        }
    }
    
    private func toolBarButton(action: Action) -> some View {
        Button(action.rawValue) {
            Task {
                if action == .create {
                    try await viewModel.createTransaction(
                        selectedCategory: selectedCategory,
                        sum: sum,
                        comment: comment,
                        date: date, time: time
                    )
                } else if action == .cancel {
                    dismissSheet()
                } else {
                    try await viewModel.putTransaction(
                        selectedCategory: selectedCategory,
                        sum: sum,
                        comment: comment,
                        date: date, time: time
                    )
                }
                switch viewModel.viewState {
                case .success:
                    dismissSheet()
                default:
                    break
                }

            }
            
        }
    }
    
    private func dismissSheet() {
        activeSheet = nil
    }
}
