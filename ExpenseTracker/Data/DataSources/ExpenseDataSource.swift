//
//  ExpenseDataSource.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import Foundation

protocol ExpenseDataSource {
    func fetchAllExpenses() async throws -> [ExpenseDTO]
    func saveExpense(_ expense: ExpenseDTO) async throws
    func deleteExpense(by id: UUID) async throws
}
