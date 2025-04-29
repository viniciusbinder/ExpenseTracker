//
//  CategoryWithExpenses.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import Foundation

struct CategoryWithExpenses: Identifiable, Equatable {
    let id: UUID
    let name: String
    let expenses: [Expense]

    var totalExpense: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }
}
