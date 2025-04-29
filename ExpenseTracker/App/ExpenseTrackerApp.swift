//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    private let container: DependencyContainer = .init()

    var body: some Scene {
        WindowGroup {
            HomeScreen(factory: container)
        }
    }
}
