import Foundation
import SwiftUI

struct NumericTextField: View {
    @FocusState private var isFocused: Bool
    @Binding var textValue: String
    
    private let decimalSeparator = Locale.current.decimalSeparator ?? "."
    private var allowedCharacterSet: CharacterSet {
        var set = CharacterSet.decimalDigits
        set.insert(charactersIn: decimalSeparator)
        return set
    }
    
    private func makeFormatter(for locale: Locale = .current) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.usesGroupingSeparator = false
        formatter.locale = locale
        return formatter
    }
    
    var body: some View {
        Section {
            HStack {
                Spacer()
                TextField(
                    "Ввведите сумму...",
                    text: $textValue
                )
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .focused($isFocused)
                .frame(minWidth: 80)
                .onChange(of: textValue) { newValue in
                    filterText(newValue)
                }
            }
            .onTapGesture {
                isFocused = true
            }
        }
    }
    
    private func filterText(_ input: String) {
        // Удалить недопустимые символы
        let filtered = String(input.unicodeScalars.filter { allowedCharacterSet.contains($0) })
        // Разрешить только один разделитель
        let components = filtered.components(separatedBy: decimalSeparator)
        let singleDecimal: String
        if components.count > 2 {
            singleDecimal = components.prefix(2).joined(separator: decimalSeparator) + components.dropFirst(2).joined()
        } else {
            singleDecimal = filtered
        }
        
        if singleDecimal != input {
            textValue = singleDecimal
        }
    }
}
