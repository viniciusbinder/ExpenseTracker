//
//  Item.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
