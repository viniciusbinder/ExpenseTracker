//
//  CategoryRepository.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import Foundation

protocol CategoryRepository {
    func fetchAll() async throws -> [Category]
    func add(_ category: Category) async throws
    func find(by name: String) async throws -> Category?
}
