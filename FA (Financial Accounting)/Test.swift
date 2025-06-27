import SwiftUI

struct TestView: View {
    @State private var showingCustomSheet = false

    var body: some View {
      Button("Выбрать валюту") { showingCustomSheet = true }
        .sheet(isPresented: $showingCustomSheet) {
          VStack(spacing: 0) {
            Button("₽") { /*…*/ showingCustomSheet = false }
            Divider()
            Button("$") { /*…*/ showingCustomSheet = false }
            Divider()
            Button("€") { /*…*/ showingCustomSheet = false }
          }
          .background(.ultraThinMaterial)
          .cornerRadius(12)
          .padding()
        }
    }

}

#Preview {
    TestView()
}
