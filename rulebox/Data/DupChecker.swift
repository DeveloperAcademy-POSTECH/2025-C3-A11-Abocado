//
//  DupChecker.swift
//  rulebox
//
//  Created by POS on 6/2/25.
//
// Duplication checker for JSON data parsing

import Foundation
import SwiftData

struct DupChecker {
    
    static func existingGameNames(context: ModelContext) throws -> Set<String> {
        let fetch = FetchDescriptor<GameName>()
        let games = try context.fetch(fetch)
        return Set(games.map { $0.name })
    }
    
    static func existingMajCats(context: ModelContext) throws -> Set<String> {
        let fetch = FetchDescriptor<MajorCat>()
        let majors = try context.fetch(fetch)
        return Set(majors.map { $0.name })
    }

    static func existingContents(forGameName name: String, context: ModelContext) throws -> Set<String> {
        let fetch = FetchDescriptor<Content>(
            predicate: #Predicate<Content> { $0.gameName.name == name }
        )
        let contents = try context.fetch(fetch)
        return Set(contents.map { $0.name })
    }
//    // if need to add 'text' in existing contents
//    static func existingFTags(context: ModelContext) throws -> Set<String> {
//        let fetch = FetchDescriptor<FilterTag>()
//        let tags = try context.fetch(fetch)
//        return Set(tags.map { "\($0.type)-\($0.value)" })
//    }

}


