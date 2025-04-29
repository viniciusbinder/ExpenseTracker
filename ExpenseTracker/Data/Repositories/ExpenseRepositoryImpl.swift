//
//  ExpenseRepositoryImpl.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import Foundation

final class ExpenseRepositoryImpl: ExpenseRepository {
    private let dataSource: ExpenseDataSource

    init(dataSource: ExpenseDataSource) {
        self.dataSource = dataSource
    }

    func fetchAll() async throws -> [Expense] {
        let dtos = try await dataSource.fetchAllExpenses()
        return dtos.map { $0.toDomain() }
    }

    func add(_ expense: Expense) async throws {
        let dto = ExpenseDTO.fromDomain(expense)
        try await dataSource.saveExpense(dto)
    }

    func delete(by id: UUID) async throws {
        try await dataSource.deleteExpense(by: id)
    }
}
