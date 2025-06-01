//
//  ruleboxApp.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//

//import SwiftUI
//import SwiftData
//
//@main
//struct ruleboxApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//        .modelContainer(sharedModelContainer)
//    }
//}

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
            FilterTable.self
        ])
        
        do {
            sharedModelContainer = try ModelContainer(for: schema)
            
            // load data at init
            let context = sharedModelContainer.mainContext
            // load data if DB empty
            let fetchRequest = FetchDescriptor<GameName>()
            let games = try context.fetch(fetchRequest)
            
            if games.isEmpty {
                if let url = Bundle.main.url(forResource: "basicRule", withExtension: "json"),
                   let jsonData = try? Data(contentsOf: url) {
                    try NLoader.loadGameRule(from: jsonData, context: context)
                    try context.save()
                    print("기본 룰북 JSON 데이터 로딩 완료")
                } else {
                    print("Error: file not found")
                }
            } else {
                print("Error: data already exist")
            }
            
        } catch {
            fatalError("Error: can't complete ModelContainer creation: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.modelContext, sharedModelContainer.mainContext)
        }
        .modelContainer(sharedModelContainer)
    }
}
