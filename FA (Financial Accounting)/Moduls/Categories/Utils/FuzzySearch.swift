//
//  FuzzySearch.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 03.07.2025.
//

import Foundation

// Расширение для String: вычисление расстояния Левенштейна до другой строки
extension String {
    func levenshteinDistance(to target: String) -> Int {
        let s = Array(self)
        let t = Array(target)
        let n = s.count, m = t.count
        
        // Если одна из строк пустая — расстояние равно длине другой
        guard n != 0 else { return m }
        guard m != 0 else { return n }
        
        // Создаём (n+1)x(m+1) матрицу
        var dp = [[Int]](repeating: [Int](repeating: 0, count: m + 1), count: n + 1)
        
        // Инициализация крайних значений
        for i in 0...n { dp[i][0] = i }
        for j in 0...m { dp[0][j] = j }
        
        // Заполнение матрицы
        for i in 1...n {
            for j in 1...m {
                let cost = s[i-1] == t[j-1] ? 0 : 1
                dp[i][j] = Swift.min(
                    dp[i-1][j] + 1,      // удаление
                    dp[i][j-1] + 1,      // вставка
                    dp[i-1][j-1] + cost  // замена или совпадение
                )
            }
        }
        
        return dp[n][m]
    }
}

