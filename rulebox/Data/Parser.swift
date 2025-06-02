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
//struct ContentDTO: Codable {
//    let id: UUID
//    let name: String
//    let text: [String]
//    let gameName: GameNameDTO
//    let majorCat: MajorCatDTO
//    let filterTables: [FilterTableDTO]?
//}
//
//struct GameNameDTO: Codable {
//    let id: UUID
//    let name: String
//    let genre: String
//}
//
//struct MajorCatDTO: Codable {
//    let id: UUID
//    let name: String
//}
//
//struct FilterTableDTO: Codable {
//    let id: UUID
//    let targetID: UUID
//    let filtertags: [FilterTagDTO]
//}
//
//struct FilterTagDTO: Codable {
//    let id: UUID
//    let value: String
//    let type: String
//}
//
//func parseRulebookData(from data: Data, context: ModelContext) {
//    let decoder = JSONDecoder()
//    
//    do {
//        let decodedContents = try decoder.decode([ContentDTO].self, from: data)
//
//        for dto in decodedContents {
//            // 중복 체크
//            guard context.fetch(Content.self).first(where: { $0.id == dto.id }) == nil else { continue }
//
//            let game = GameName(id: dto.gameName.id, name: dto.gameName.name, genre: dto.gameName.genre)
//            let major = MajorCat(id: dto.majorCat.id, name: dto.majorCat.name)
//            let content = Content(id: dto.id, name: dto.name, text: dto.text, image: nil, gameName: game, majorCat: major)
//
//            // 필터 테이블
//            if let filterTableDTOs = dto.filterTables {
//                for ftDTO in filterTableDTOs {
//                    let tags = ftDTO.filtertags.map {
//                        FilterTag(id: $0.id, value: $0.value, type: $0.type)
//                    }
//                    let ft = FilterTable(id: ftDTO.id, targetID: ftDTO.targetID, filtertags: tags)
//                    content.filterTables.append(ft)
//                }
//            }
//
//            context.insert(content)
//        }
//
//        try context.save()
//        print("--- parsing success ---")
//
//    } catch {
//        print("Parser Error:: can't parse json data: \(error)")
//    }
//}
