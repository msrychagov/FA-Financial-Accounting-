import SwiftUI

struct MHistoryView: View {
    @State private var startDate = Date()
    var body: some View {
        List {
            Section("Критерии") {
                HStack {
                    Text("Начало")
                    Spacer()
                    DatePicker(
                        "Начало",
                        selection: $startDate,
                        displayedComponents: .date
                    )
                    .labelsHidden()
                    .tint(.purple)
                    .background(Color(red: 212/255.0, green: 250/255.0, blue: 230/255.0).cornerRadius(8))
                }
                
            }
            
        }
    }
    
}

#Preview {
    MHistoryView()
}
