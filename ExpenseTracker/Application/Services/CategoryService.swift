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

    func loadCategoriesWithExpenses() async throws -> [CategoryWithExpenses] {
        async let fetchCategories = categoryRepository.fetchAll()
        async let fetchExpenses = expenseRepository.fetchAll()
        let (categories, expenses) = try await (fetchCategories, fetchExpenses)

        let expensesByCategory = Dictionary(grouping: expenses, by: { $0.categoryId })

        return categories.map { category in
            CategoryWithExpenses(
                id: category.id,
                name: category.name,
                expenses: expensesByCategory[category.id] ?? []
            )
        }
    }

    func loadExpenses(for categoryId: UUID) async throws -> [Expense] {
        let allExpenses = try await expenseRepository.fetchAll()
        return allExpenses.filter { $0.categoryId == categoryId }
    }
}
