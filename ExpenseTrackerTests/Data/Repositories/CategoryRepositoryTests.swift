//
//  CategoryRepositoryTests.swift
//  ExpenseTrackerTests
//
//  Created by Vinícius on 07/05/25.
//

@testable import ExpenseTracker
import Foundation
import Testing

struct CategoryRepositoryTests {
    @Test("Fetch stored categories")
    func fetchCategories() async throws {
        let repository: CategoryRepository = .mock()
        let result = try await repository.fetchAll()
        
        #expect(result.count == MockData.categories.count)
        #expect(result.first!.id == MockData.categories.first!.id)
    }
    
    @Test("Save new category")
    func saveCategory() async throws {
        let repository: CategoryRepository = .empty
        let category = Category(id: UUID(), name: "Test")
        try await repository.add(category)
        
        let result = try await repository.fetchAll()
        
        #expect(result.count == 1)
        #expect(result.first!.id == category.id)
    }
    
    @Test("Find stored category by name")
    func findCategory() async throws {
        let repository: CategoryRepository = .mock()
        let category = MockData.categories.first!
        
        let result = try await repository.find(by: category.name)
        
        #expect(result?.name == category.name)
    }
    
    @Test("Category not found")
    func findCategoryNil() async throws {
        let repository: CategoryRepository = .mock()
        let result = try await repository.find(by: "nonexistent")
        
        #expect(result == nil)
    }
}
