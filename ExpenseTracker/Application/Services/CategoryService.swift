//
//  CategoryService.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import Foundation

final class CategoryService {
    private let categoryRepository: CategoryRepository
    private let expenseRepository: ExpenseRepository

    init(categoryRepository: CategoryRepository, expenseRepository: ExpenseRepository) {
        self.categoryRepository = categoryRepository
        self.expenseRepository = expenseRepository
    }

    func loadCategories() async throws -> [Category] {
        try await categoryRepository.fetchAll()
    }

    func loadExpenses(for categoryId: UUID) async throws -> [Expense] {
        let allExpenses = try await expenseRepository.fetchAll()
        return allExpenses.filter { $0.categoryId == categoryId }
    }
}
