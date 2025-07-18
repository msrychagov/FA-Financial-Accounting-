//
//  BackUp.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.07.2025.
//

protocol BackUp {
    associatedtype Entity
    func fetchAll() async throws -> [Entity]
    func add(_ entity: Entity) async throws
    func delete(_ entity: Entity) async throws
}
