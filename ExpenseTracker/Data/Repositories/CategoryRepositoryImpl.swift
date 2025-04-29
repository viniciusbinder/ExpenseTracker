//
//  CategoryRepositoryImpl.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import Foundation

final class CategoryRepositoryImpl: CategoryRepository {
    private let dataSource: CategoryDataSource

    init(dataSource: CategoryDataSource) {
        self.dataSource = dataSource
    }

    func fetchAll() async throws -> [Category] {
        let dtos = try await dataSource.fetchAllCategories()
        return dtos.map { $0.toDomain() }
    }

    func add(_ category: Category) async throws {
        let dto = CategoryDTO.fromDomain(category)
        try await dataSource.saveCategory(dto)
    }

    func find(by name: String) async throws -> Category? {
        if let dto = try await dataSource.findCategory(by: name) {
            return dto.toDomain()
        } else {
            return nil
        }
    }
}
