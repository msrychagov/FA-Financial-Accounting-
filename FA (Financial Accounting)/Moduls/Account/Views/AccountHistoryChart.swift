import SwiftUI
import Charts

struct AccountHistoryChart: View {
    var history: [BalanceOnDate] = []

    @State private var selectedEntry: BalanceOnDate?
    @State private var currentLocation: CGPoint?
    @State private var isAnnotationVisible = false

    var body: some View {
        Chart {
            ForEach(history, id: \.date) { item in
                BarMark(
                    x: .value("Date", item.date, unit: .day),
                    y: .value("Balance", abs(item.balance))
                )
                .cornerRadius(5)
                .foregroundStyle(item.balance < 0 ? .red : .green)
                .opacity(selectedEntry?.date == item.date ? 1 : 0.6)
                .annotation(position: .top, alignment: .center) {
                    if selectedEntry?.date == item.date && isAnnotationVisible {
                        Text(item.balance, format: .currency(code: "RUB"))
                            .font(.caption2)
                            .padding(6)
                            .background(.ultraThinMaterial)
                            .cornerRadius(5)
                            .offset(y: -8)
                    }
                }
            }
        }
        .chartXAxis {
            AxisMarks(values: .automatic) { _ in
                AxisValueLabel()
                AxisTick()
            }
        }
        .chartYAxis(.hidden)
        .chartOverlay { proxy in
            GeometryReader { geo in
                Rectangle()
                    .fill(Color.clear)
                    .contentShape(Rectangle())
                    // лонг‑пресс
                    .highPriorityGesture(
                        LongPressGesture(minimumDuration: 0.4)
                            .onEnded { _ in
                                guard let loc = currentLocation else { return }
                                selectEntry(at: loc, proxy: proxy)
                                isAnnotationVisible = true
                            }
                    )
                    // перетаскивание
                    .simultaneousGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { drag in
                                currentLocation = drag.location
                                if isAnnotationVisible {
                                    selectEntry(at: drag.location, proxy: proxy)
                                }
                            }
                            .onEnded { _ in
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    isAnnotationVisible = false
                                    selectedEntry = nil
                                }
                            }
                    )
            }
        }
    }

    private func selectEntry(at location: CGPoint, proxy: ChartProxy) {
        if let date: Date = proxy.value(atX: location.x) {
            selectedEntry = history.min(by: {
                abs($0.date.timeIntervalSince(date)) < abs($1.date.timeIntervalSince(date))
            })
        }
    }
}
