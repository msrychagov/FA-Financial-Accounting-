
final class CategoriesService {
    private(set) var categories: [Category] = []
    
    init() {
        Task {
            categories = try await loadCategories()
        }
    }
    private func categoriesFromServer() -> [Category] {
        let categories: [Category] = [
            Category(id: 1, name: "Подработка", emoji: "💸", isIncome: .income),
            Category(id: 2, name: "Зарплата", emoji: "💰", isIncome: .income),
            Category(id: 3, name: "Аренда квартиры", emoji: "🏠", isIncome: .outcome),
            Category(id: 4, name: "Одежда", emoji: "👔", isIncome: .outcome),
            Category(id: 5, name: "На собачку", emoji: "🐕", isIncome: .outcome),
            Category(id: 6, name: "Ремонт квартиры", emoji: "🔨", isIncome: .outcome),
            Category(id: 7, name: "Продукты", emoji: "🍬", isIncome: .outcome),
            Category(id: 8, name: "Спортзал", emoji: "🏋️‍♀️", isIncome: .outcome),
            Category(id: 9, name: "Медицина", emoji: "💊", isIncome: .outcome),
            Category(id: 10, name: "Аптека", emoji: "💜", isIncome: .outcome),
            Category(id: 11, name: "Машина", emoji: "🚗", isIncome: .outcome),
            Category(id: 12, name: "Деп", emoji: "💰", isIncome: .outcome)
        ]
        
        return categories
    }
    
    func loadCategories() async throws -> [Category] {
        categoriesFromServer()
    }
    
    func selectCategories(by direction: Direction) async throws -> [Category] {
        return categories.filter { $0.isIncome == direction }
    }
    
    // Добавил метод для получения категории по id, т.к. при изменении Transaction передается categoryId, а вернуть нужно Transaction, где поле - Category
    func category(id: Int) async throws -> Category? {
//        let categories = try await categories()
        return categories.first(where: { $0.id == id })
    }
}
