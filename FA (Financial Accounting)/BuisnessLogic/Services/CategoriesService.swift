
final class CategoriesService {
    func categories() async -> [Category] {
        let categories: [Category] = [
            Category(id: 1, name: "Одежда", emoji: "🧢", isIncome: .outcome),
            Category(id: 2, name: "Зарплата", emoji: "💰", isIncome: .income),
            Category(id: 3, name: "Подработка", emoji: "💸", isIncome: .income),
            Category(id: 4, name: "Спортзал", emoji: "🏋️‍♂️", isIncome: .outcome),
        ]
        
        return categories
    }
    
    func selectCategories(by direction: Direction) async -> [Category] {
        return await categories().filter { $0.isIncome == direction }
    }
}
