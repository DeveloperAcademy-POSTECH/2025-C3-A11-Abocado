//
//  JSONParser.swift
//  rulebox
//
//  Created by POS on 6/2/25.
//

import Foundation
import SwiftData

struct Rule: Decodable {
    let gameName: String
    let genres: [String]
    let contents: [ContentItem]
}

struct ContentItem: Decodable {
    let majorCat: String
    let name: String
    let texts: [String]
    let images: [String]?
    let filterTags: [FilterTagItem]
}

struct FilterTagItem: Decodable {
    let type: String
    let value: String
}

struct JSONParser {
    static func loadGameRule(from jsonData: Data, context: ModelContext) throws {
        let decoder = JSONDecoder()
        let Rule = try decoder.decode(Rule.self, from: jsonData)

        let gameName = Rule.gameName
        let existingGameNames = try DupChecker.existingGameNames(context: context)
        let isExisting = existingGameNames.contains(gameName)

        // GameName: load or create new instance
        let game: GameName
        if isExisting {
            let fetch = FetchDescriptor<GameName>(
                predicate: #Predicate { $0.name == gameName }
            )
            game = try context.fetch(fetch).first!
        } else {
            game = GameName(name: gameName, genres: Rule.genres)
            context.insert(game)
        }

        // MajorCat: check for cache. is no duplicated name >> create new instance
        var majorCatCache: [String: MajorCat] = [:]
        let existingMajs = try DupChecker.existingMajCats(context: context)

        func getOrCreateMajorCat(named name: String) -> MajorCat {
            if let cached = majorCatCache[name] {
                return cached
            }
            if existingMajs.contains(name) {
                let fetch = FetchDescriptor<MajorCat>(
                    predicate: #Predicate { $0.name == name }
                )
                if let existing = try? context.fetch(fetch).first {
                    majorCatCache[name] = existing
                    return existing
                }
            }
            let newMajor = MajorCat(name: name)
            context.insert(newMajor)
            majorCatCache[name] = newMajor
            return newMajor
        }

        // Content: if no duplicated name >> create new instance
        let existingContents = isExisting ? try DupChecker.existingContents(forGameName: gameName, context: context) : []

        for item in Rule.contents {
            guard !existingContents.contains(item.name) else { continue }

            let majorCat = getOrCreateMajorCat(named: item.majorCat)

            let tags = item.filterTags.map {
                let tag = FilterTag(value: $0.value, type: $0.type)
                context.insert(tag)
                return tag
            }

            let filterTable = FilterTable(targetID: UUID(), filtertags: tags)
            context.insert(filterTable)

            let content = Content(
                name: item.name,
                texts: item.texts,
                images: nil,
                gameName: game,
                majorCat: majorCat
            )
            content.filterTable = filterTable
            filterTable.content = content
            filterTable.targetID = content.id

            context.insert(content)
        }
    }
}
