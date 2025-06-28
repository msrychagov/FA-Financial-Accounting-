import Foundation
import SwiftUI

struct BalanceRow: View {
    @Binding var balance: Decimal
    @FocusState private var isFocused: Bool
    @State private var textValue: String = ""
    
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
                Text("💰")
                Text("Баланс")
                Spacer()
                TextField(
                    "",
                    text: $textValue
                )
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .focused($isFocused)
                .frame(minWidth: 80)
                .onChange(of: textValue) { newValue in
                    filterText(newValue)
                }
                // Обновляем отображение при смене фокуса
                .onChange(of: isFocused) { focused in
                    let formatter = makeFormatter()
                    textValue = formatter.string(from: NSDecimalNumber(decimal: balance)) ?? ""
                }
                .onChange(of: balance) { newBalance in
                    let formatter = makeFormatter()
                    textValue = formatter.string(from: NSDecimalNumber(decimal: newBalance)) ?? ""
                }
            }
            .onAppear {
                textValue = makeFormatter().string(from: NSDecimalNumber(decimal: balance)) ?? ""
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
        
        // Обновить привязанный баланс
        let plainString = singleDecimal.replacingOccurrences(of: decimalSeparator, with: ".")
        if let decimal = Decimal(string: plainString) {
            balance = decimal
        } else if singleDecimal.isEmpty {
            balance = .zero
        }
    }
}
