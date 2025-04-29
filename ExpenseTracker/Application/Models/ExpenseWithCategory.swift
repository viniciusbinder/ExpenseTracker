//
//  ExpenseWithCategory.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import Foundation

struct ExpenseWithCategory: Identifiable, Equatable {
    let id: UUID
    let amount: Double
    let date: Date
    let category: Category
    let note: String?
}
