//
//  StringToCharacter.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 17.07.2025.
//

protocol ConverterToCharacter {
    func convertToCharacter() -> Character
}

extension String: ConverterToCharacter {
    func convertToCharacter() -> Character {
        guard self.count == 1 else {
            fatalError("Невозможно преобразовать строку \(self) в символ")
        }
        
        return Character(self)
    }
}
