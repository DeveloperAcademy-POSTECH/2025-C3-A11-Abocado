////
////  ParseTestView.swift
////  rulebox
////
////  Created by POS on 6/2/25.
////
//
//import SwiftUI
//import SwiftData
//
//struct DebugDataView: View {
//    @Query var games: [GameName]
//    @Query var majors: [MajorCat]
//    @Query var contents: [Content]
//    @Query var filters: [FilterTable]
//    @Query var tags: [FilterTag]
//
//    var body: some View {
//        NavigationStack {
//            List {
//                Section("🎮 GameName") {
//                    ForEach(games) { game in
//                        VStack(alignment: .leading) {
//                            Text("Name: \(game.name)")
//                            Text("Genre: \(game.genre.joined(separator: ", "))")
//                                .font(.caption)
//                                .foregroundColor(.gray)
//                        }
//                    }
//                }
//
//                Section("📁 MajorCat") {
//                    ForEach(majors) { cat in
//                        Text(cat.name)
//                    }
//                }
//
//                Section("📄 Content") {
//                    ForEach(contents) { content in
//                        VStack(alignment: .leading, spacing: 6) {
//                            Text("Name: \(content.name)")
//                                .fontWeight(.bold)
//                            Text("Texts: \(content.texts.joined(separator: " / "))")
//                                .font(.caption)
//                            if let ft = content.filterTable {
//                                Text("→ FilterTable ID: \(ft.id.uuidString.prefix(8))")
//                                    .font(.caption2)
//                                    .foregroundColor(.blue)
//                            }
//                        }
//                    }
//                }
//
//                Section("🔗 FilterTable") {
//                    ForEach(filters) { filter in
//                        VStack(alignment: .leading, spacing: 4) {
//                            Text("TargetID: \(filter.targetID.uuidString.prefix(8))")
//                            Text("Tags: \(filter.filtertags.map { "\($0.type): \($0.value)" }.joined(separator: ", "))")
//                                .font(.caption)
//                                .foregroundColor(.secondary)
//                        }
//                    }
//                }
//
//                Section("🏷️ FilterTags") {
//                    ForEach(tags) { tag in
//                        Text("\(tag.type): \(tag.value)")
//                    }
//                }
//            }
//            .navigationTitle("📦 Debug Data")
//        }
//    }
//}
//struct DebugDataView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = GameName(name: "Carcassonne", genres: ["Board", "Strategy"])
//        let major = MajorCat(name: "Setup")
//        let tag1 = FilterTag(value: "2-4", type: "Player")
//        let tag2 = FilterTag(value: "Base", type: "Expansion")
//        let table = FilterTable(targetID: UUID(), filtertags: [tag1, tag2])
//        let content = Content(
//            name: "Place Starting Tile",
//            texts: ["Find the starting tile", "Place it in center"],
//            images: [],
//            gameName: game,
//            majorCat: major
//        )
//        content.filterTable = table
//
//        let mockView = List {
//            Section("📄 Mock Content") {
//                VStack(alignment: .leading) {
//                    Text("Name: \(content.name)")
//                    Text("Texts: \(content.texts.joined(separator: ", "))")
//                    Text("Game: \(game.name)")
//                    Text("MajorCat: \(major.name)")
//                    Text("Tags: \(table.filtertags.map { "\($0.type): \($0.value)" }.joined(separator: ", "))")
//                }
//            }
//        }
//
//        return NavigationStack {
//            mockView
//                .navigationTitle("📦 Debug Preview")
//        }
//    }
//}
