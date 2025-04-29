//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import Foundation

struct Expense: Identifiable, Equatable {
    let id: UUID
    let amount: Double
    let date: Date
    let categoryId: UUID
    let note: String?
}
