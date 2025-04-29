//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ExpenseListScreen(viewModel: .init(service: .mock()))
        }
    }
}
