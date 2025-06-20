//
//  Test.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.06.2025.
//

import SwiftUI

// MARK: — Model

/// Наша простая модель-счётчик
class CounterModel: ObservableObject {
    @Published private(set) var count: Int = 0
    
    func increment() {
        count += 1
    }
}

// MARK: — FirstView (View)

struct FirstView: View {
    // 1) Храним модель в качестве источника истины
    @StateObject private var model = CounterModel()
    // 2) Флаг для программного перехода
    @State private var showDetail = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Current count: \(model.count)")
                    .font(.title)

                // 3) Обычная Button, которая меняет флаг
                Button("Перейти к деталям") {
                    showDetail = true
                }
                .buttonStyle(.borderedProminent)

                // 4) Скрытый NavigationLink, слушающий showDetail
                NavigationLink(
                    destination: DetailView(model: model),
                    isActive: $showDetail
                ) {
                    EmptyView()
                }
                .hidden()
            }
            .padding()
            .navigationTitle("Главный экран")
        }
    }
}

// MARK: — DetailView (View)

struct DetailView: View {
    // 1) Получаем модель из родительского экрана
    @ObservedObject var model: CounterModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Detail count: \(model.count)")
                .font(.largeTitle)

            // 2) Меняем модель через метод
            Button("Увеличить счётчик") {
                model.increment()
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .navigationTitle("Экран деталей")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: — Запуск в Preview

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
