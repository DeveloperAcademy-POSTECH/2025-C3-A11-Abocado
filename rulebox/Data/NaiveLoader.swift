//
//  NaiveLoader.swift
//  rulebox
//
//  Created by POS on 6/2/25.
//
//  JSON Loader,Parser 구현실패에 따른 극단적인 선택.
//  새 데이터를 추가해야 할 때 마다 '기존 데이터를 완전히 지우고 재설치'
//  시간 여유 있을 때 반드시 고칠게.. DB야 미안해ㅠ

import Foundation
import SwiftData

struct BasicRule: Decodable {
    let gameName: String
    let genre: String
    let contents: [ContentItem]
}

struct ContentItem: Decodable {
    let majorCat: String
    let name: String
    let text: String
    let image: String?
    let filterTags: [FilterTagItem]
}

struct FilterTagItem: Decodable {
    let type: String
    let value: String
}

struct NLoader {
    static func loadGameRule(from jsonData: Data, context: ModelContext) throws {
        //  JSON parsing
        let decoder = JSONDecoder()
        let basicRule = try decoder.decode(BasicRule.self, from: jsonData)

        //  remove existing data ( ... )
        let gameName = basicRule.gameName
        let fetchGame = FetchDescriptor<GameName>(predicate: #Predicate<GameName> { $0.name == gameName })

        
        let existingGames = try context.fetch(fetchGame)
        for game in existingGames {
            context.delete(game)
        }

        //  insert data
        let game = GameName(name: basicRule.gameName, genre: basicRule.genre)
        context.insert(game)

        var majorCatCache: [String: MajorCat] = [:]
        for contentItem in basicRule.contents {
            let majorCat = majorCatCache[contentItem.majorCat] ?? {
                let newMajor = MajorCat(name: contentItem.majorCat)
                context.insert(newMajor)
                majorCatCache[contentItem.majorCat] = newMajor
                return newMajor
            }()

            let tags = contentItem.filterTags.map { tagItem -> FilterTag in
                let tag = FilterTag(value: tagItem.value, type: tagItem.type)
                context.insert(tag)
                return tag
            }

            let filterTable = FilterTable(targetID: UUID(), filtertags: tags)
            context.insert(filterTable)

            let content = Content(
                name: contentItem.name,
                text: contentItem.text,
                image: nil,
                gameName: game,
                majorCat: majorCat
            )
            content.filterTables.append(filterTable)
            context.insert(content)

            filterTable.targetID = content.id
        }
    }
}

