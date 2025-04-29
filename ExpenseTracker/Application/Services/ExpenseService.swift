//
//  ExpenseService.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import Foundation

final class ExpenseService {
    private let expenseRepository: ExpenseRepository
    private let categoryRepository: CategoryRepository

    init(expenseRepository: ExpenseRepository, categoryRepository: CategoryRepository) {
        self.expenseRepository = expenseRepository
        self.categoryRepository = categoryRepository
    }

    func fetchExpensesWithCategories() async throws -> [ExpenseWithCategory] {
        async let fetchCategories = categoryRepository.fetchAll()
        async let fetchExpenses = expenseRepository.fetchAll()
        let (categories, expenses) = try await (fetchCategories, fetchExpenses)

        let categoriesById = Dictionary(uniqueKeysWithValues: categories.map { ($0.id, $0) })

        return expenses.compactMap { expense in
            guard let category = categoriesById[expense.categoryId] else { return nil }
            return ExpenseWithCategory(
                id: expense.id,
                amount: expense.amount,
                date: expense.date,
                category: category,
                note: expense.note
            )
        }
    }

    func addExpense(amount: Double, date: Date, categoryName: String, note: String?) async throws {
        let category = try await findOrCreateCategory(named: categoryName)
        let expense = Expense(id: UUID(), amount: amount, date: date, categoryId: category.id, note: note)
        try await expenseRepository.add(expense)
    }

    func deleteExpense(by id: UUID) async throws {
        try await expenseRepository.delete(by: id)
    }

    private func findOrCreateCategory(named name: String) async throws -> Category {
        if let existing = try await categoryRepository.find(by: name) {
            return existing
        } else {
            let newCategory = Category(id: UUID(), name: name)
            try await categoryRepository.add(newCategory)
            return newCategory
        }
    }
}
