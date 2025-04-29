//
//  CategoryDataSource.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import Foundation

protocol CategoryDataSource {
    func fetchAllCategories() async throws -> [CategoryDTO]
    func saveCategory(_ category: CategoryDTO) async throws
    func findCategory(by name: String) async throws -> CategoryDTO?
}
