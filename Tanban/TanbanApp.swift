//
//  TanbanApp.swift
//  Tanban
//
//  Created by Luca on 21/04/2025.
//

import SwiftData
import SwiftUI

@main
struct TanbanApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Kanban.self,
            Column.self,
            Card.self,
            ColorRGB.self
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
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
