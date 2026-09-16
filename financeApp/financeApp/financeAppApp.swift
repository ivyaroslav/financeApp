//
//  financeAppApp.swift
//  financeApp
//
//  Created by yaroslav on 13/09/2026.
//

import SwiftUI
import CoreData
@main
struct financeAppApp: App {
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .background {
                let context = persistenceController.container.viewContext
                if context.hasChanges {
                    try? context.save()
                }
            }
        }
    }
    
}
