//
//  ExpenseRepositoryTests.swift
//  ExpenseTrackerTests
//
//  Created by Vinícius on 07/05/25.
//

@testable import ExpenseTracker
import Foundation
import Testing

struct ExpenseRepositoryTests {
    @Test("Fetch stored expenses")
    func fetchExpenses() async throws {
        let repository: ExpenseRepository = .mock()
        let result = try await repository.fetchAll()
        
        #expect(result.count == MockData.expenses.count)
        #expect(result.first!.id == MockData.expenses.first!.id)
    }
    
    @Test("Save new expense")
    func saveExpense() async throws {
        let repository: ExpenseRepository = .empty
        let expense = MockData.expenses.first!.toDomain()
        try await repository.add(expense)
        
        let result = try await repository.fetchAll()
        
        #expect(result.count == 1)
        #expect(result.first!.id == MockData.expenses.first!.id)
    }
    
    @Test("Delete stored expense")
    func deleteExpense() async throws {
        let repository: ExpenseRepository = .mock()
        let expense = MockData.expenses.first!
        try await repository.delete(by: expense.id)
        
        let result = try await repository.fetchAll()
        
        #expect(result.count == MockData.expenses.count - 1)
        #expect(result.contains { $0.id == expense.id } == false)
    }
}
