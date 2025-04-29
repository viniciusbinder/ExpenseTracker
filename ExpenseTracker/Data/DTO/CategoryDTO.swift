//
//  CategoryDTO.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import Foundation
import SwiftData

@Model
final class CategoryDTO: Identifiable {
    @Attribute(.unique) var id: UUID
    var name: String

    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}

extension CategoryDTO {
    func toDomain() -> Category {
        Category(id: id, name: name)
    }

    static func fromDomain(_ category: Category) -> CategoryDTO {
        CategoryDTO(id: category.id, name: category.name)
    }
}
