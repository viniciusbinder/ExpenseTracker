//
//  InMemoryStorage.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import Foundation

final class InMemoryStorage {
    private var expenses: [ExpenseDTO]
    private var categories: [CategoryDTO]

    init(expenses: [ExpenseDTO] = [], categories: [CategoryDTO] = []) {
        self.expenses = expenses
        self.categories = categories
    }
}

// MARK: - ExpenseDataSource
extension InMemoryStorage: ExpenseDataSource {
    func fetchAllExpenses() async throws -> [ExpenseDTO] {
        expenses
    }

    func saveExpense(_ expense: ExpenseDTO) async throws {
        expenses.append(expense)
    }

    func deleteExpense(by id: UUID) async throws {
        expenses.removeAll { $0.id == id }
    }
}

// MARK: - CategoryDataSource
extension InMemoryStorage: CategoryDataSource {
    func fetchAllCategories() async throws -> [CategoryDTO] {
        categories
    }

    func saveCategory(_ category: CategoryDTO) async throws {
        categories.append(category)
    }

    func findCategory(by name: String) async throws -> CategoryDTO? {
        categories.first { $0.name == name }
    }
}
