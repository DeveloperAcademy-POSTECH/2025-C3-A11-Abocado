//
//  ruleboxApp.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//


import SwiftUI
import SwiftData

@main
struct ruleboxApp: App {
    let sharedModelContainer: ModelContainer

    init() {
        let schema = Schema([
            GameName.self,
            MajorCat.self,
            Content.self,
            FilterTag.self,
            FilterTable.self,
            SearchGames.self,
            SearchRules.self
            Bookmark.self
        ])

        do {
            sharedModelContainer = try ModelContainer(for: schema)
            
            let context = sharedModelContainer.mainContext
            
            // scan all json file in bundle
            let jsonFileNames = [   "Carcassonne", "CockroachPoker", "Sabotage", "Avalon", "Bonanza"    ]
            
            for fileName in jsonFileNames {
                if let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
                   let jsonData = try? Data(contentsOf: url) {
                    do {
                        try JSONParser.loadGameRule(from: jsonData, context: context)
                        print("Loaded \(fileName).json")
                    } catch {
                        print("Failed to load \(fileName).json: \(error)")
                    }
                } else {
                    print("File \(fileName).json not found")
                }
            }
            
            try context.save()
            print("--- All JSON files loaded and saved ---")

        } catch {
            fatalError("Error: can't complete ModelContainer creation: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.modelContext, sharedModelContainer.mainContext)
                .preferredColorScheme(.dark)
                .foregroundColor(.white)
        }
        .modelContainer(sharedModelContainer)
    }
}

