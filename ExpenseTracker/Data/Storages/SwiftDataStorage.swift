//
//  SwiftDataStorage.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import Foundation
import SwiftData

final class SwiftDataStorage {
    private let context: ModelContext

    init(inMemoryOnly: Bool = false) {
        let schema = Schema([ExpenseDTO.self, CategoryDTO.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: inMemoryOnly)
        let modelContainer = try! ModelContainer(for: schema, configurations: [modelConfiguration])
        context = ModelContext(modelContainer)
    }
}

// MARK: - ExpenseDataSource
extension SwiftDataStorage: ExpenseDataSource {
    func fetchAllExpenses() async throws -> [ExpenseDTO] {
        let descriptor = FetchDescriptor<ExpenseDTO>()
        return try context.fetch(descriptor)
    }

    func saveExpense(_ expense: ExpenseDTO) async throws {
        context.insert(expense)
        try context.save()
    }

    func deleteExpense(by id: UUID) async throws {
        let descriptor = FetchDescriptor<ExpenseDTO>(predicate: #Predicate { $0.id == id })
        if let expense = try context.fetch(descriptor).first {
            context.delete(expense)
            try context.save()
        }
    }
}

// MARK: - CategoryDataSource
extension SwiftDataStorage: CategoryDataSource {
    func fetchAllCategories() async throws -> [CategoryDTO] {
        let descriptor = FetchDescriptor<CategoryDTO>()
        return try context.fetch(descriptor)
    }

    func saveCategory(_ category: CategoryDTO) async throws {
        context.insert(category)
        try context.save()
    }

    func findCategory(by name: String) async throws -> CategoryDTO? {
        let descriptor = FetchDescriptor<CategoryDTO>(predicate: #Predicate { $0.name == name })
        return try context.fetch(descriptor).first
    }
}
