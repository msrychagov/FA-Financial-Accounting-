import SwiftUI

struct MHistoryView: View {
  @State private var startDate = Date()
  var body: some View {
    List {
      Section("Критерии") {
        DatePicker("Начало", selection: $startDate, displayedComponents: .date)
          .datePickerStyle(.compact)
          .tint(.purple)                             // цвет capsule + текста
          .listRowBackground(Color.blue.opacity(0.1)) // фон ячейки
      }
    }
    .listStyle(.insetGrouped)
  }
}


#Preview {
    MHistoryView()
}
