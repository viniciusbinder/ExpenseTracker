//
//  ExpenseDTO.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import Foundation
import SwiftData

@Model
final class ExpenseDTO: Identifiable {
    @Attribute(.unique) var id: UUID
    var amount: Double
    var date: Date
    var categoryId: UUID
    var note: String?

    init(id: UUID, amount: Double, date: Date, categoryId: UUID, note: String?) {
        self.id = id
        self.amount = amount
        self.date = date
        self.categoryId = categoryId
        self.note = note
    }
}

extension ExpenseDTO {
    func toDomain() -> Expense {
        Expense(id: id, amount: amount, date: date, categoryId: categoryId, note: note)
    }

    static func fromDomain(_ expense: Expense) -> ExpenseDTO {
        ExpenseDTO(id: expense.id, amount: expense.amount, date: expense.date, categoryId: expense.categoryId, note: expense.note)
    }
}
