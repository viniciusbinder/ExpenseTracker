//
//  ExpenseRepository.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import Foundation

protocol ExpenseRepository {
    func fetchAll() async throws -> [Expense]
    func add(_ expense: Expense) async throws
    func delete(by id: UUID) async throws
}
