
final class CategoriesService {
    func categories() async throws -> [Category] {
        let categories: [Category] = [
            Category(id: 1, name: "Одежда", emoji: "🧢", isIncome: .outcome),
            Category(id: 2, name: "Зарплата", emoji: "💰", isIncome: .income),
            Category(id: 3, name: "Подработка", emoji: "💸", isIncome: .income),
            Category(id: 4, name: "Спортзал", emoji: "🏋️‍♂️", isIncome: .outcome),
        ]
        
        return categories
    }
    
    func selectCategories(by direction: Direction) async throws -> [Category] {
        return try await categories().filter { $0.isIncome == direction }
    }
    
    // Добавил метод для получения категории по id, т.к. при изменении Transaction передается categoryId, а вернуть нужно Transaction, где поле - Category
    func category(id: Int) async throws -> Category? {
        let categories = try await categories()
        return categories.first(where: { $0.id == id })
    }
}
