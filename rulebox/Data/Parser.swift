////
////  Parser.swift
////  rulebox
////
////  Created by POS on 6/1/25.
////
//
//import Foundation
//import SwiftData
//
//struct BasicRule: Decodable {
//    let gameName: String
//    let genre: String
//    let contents: [ContentItem]
//}
//
//struct ContentItem: Decodable {
//    let majorCat: String
//    let name: String
//    let text: String
//    let image: String?
//    let filterTags: [FilterTagItem]
//}
//
//struct FilterTagItem: Decodable {
//    let type: String
//    let value: String
//}
//
//struct Parser {
//    static func parseBasicRule(from data: Data, context: ModelContext) throws {
//        let decoder = JSONDecoder()
//        let basicRule = try decoder.decode(BasicRule.self, from: data)
//
//        // GameName 중복 생성 방지
//        let fetchRequest = FetchDescriptor<GameName>(
//            predicate: #Predicate<GameName> {
//                $0.name == basicRule.gameName
//            }
//        )
//
//        let existingGames = try context.fetch(fetchRequest)
//        let game: GameName
//        if let existing = existingGames.first {
//            game = existing
//        } else {
//            game = GameName(name: basicRule.gameName, genre: basicRule.genre)
//            context.insert(game)
//        }
//
//        // MajorCat 중복 생성 방지
//        var majorCatCache: [String: MajorCat] = [:]
//
//        for contentItem in basicRule.contents {
//            let majorFetch = FetchDescriptor<MajorCat>(
//                predicate: #Predicate<MajorCat> {
//                    $0.name == contentItem.majorCat
//                }
//            )
//            let existingMajorCats = try context.fetch(majorFetch)
//
//            let majorCat: MajorCat
//            if let existingMajor = existingMajorCats.first {
//                majorCat = existingMajor
//            } else if let cachedMajor = majorCatCache[contentItem.majorCat] {
//                majorCat = cachedMajor
//            } else {
//                majorCat = MajorCat(name: contentItem.majorCat)
//                context.insert(majorCat)
//                majorCatCache[contentItem.majorCat] = majorCat
//            }
//
//            let tags = contentItem.filterTags.map { tagItem -> FilterTag in
//                let tag = FilterTag(value: tagItem.value, type: tagItem.type)
//                context.insert(tag)
//                return tag
//            }
//
//            // 일단 UUID() 임시 할당
//            let filterTable = FilterTable(targetID: UUID(), filtertags: tags)
//            context.insert(filterTable)
//
//            let content = Content(
//                name: contentItem.name,
//                text: contentItem.text,
//                image: nil,
//                gameName: game,
//                majorCat: majorCat
//            )
//            content.filterTables.append(filterTable)
//            context.insert(content)
//
//            filterTable.targetID = content.id
//        }
//    }
//}
