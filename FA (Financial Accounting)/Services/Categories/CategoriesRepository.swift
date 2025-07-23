//
//  CategoriesRepository.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 18.07.2025.
//

final class CategoriesRepository {
    private let client: NetworkClient
    
    init(client: NetworkClient = NetworkClient()) {
        self.client = client
    }
    
    func fetchAll() async throws -> [Category] {
        let endpoint = CategoryEndpoint.all
        guard let cateogiresDTO: [CategoryDTO] = try await client.request(endpoint: endpoint) else {
            throw Errors.emptyCategoriesList
        }
        
        return try cateogiresDTO.convertToBuisnessModels()
    }
    
    func fetchTypeList(direction: Direction) async throws -> [Category] {
        let endpoint = CategoryEndpoint.type(direction: direction)
        guard let categoriesDTO: [CategoryDTO] = try await client.request(endpoint: endpoint) else {
            throw Errors.emptyCategoriesList
        }
        
        return try categoriesDTO.convertToBuisnessModels()
    }
}
