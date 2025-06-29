//
//  FitTrackerApp.swift
//  FitTracker
//
//  Created by Rachael LaMassa on 6/8/25.
//

import SwiftUI
import SwiftData

@main
struct FitTrackerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            BrowseView()
        }
        .modelContainer(sharedModelContainer)
    }
}
