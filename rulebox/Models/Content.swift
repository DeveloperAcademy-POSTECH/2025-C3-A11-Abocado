//
//  Content.swift
//  rulebox
//
//  Created by POS on 6/1/25.
//
// image처리 어떻게 할지 고려해봐야함

import Foundation
import SwiftData

@Model
class Content {
    @Attribute(.unique) var id: UUID
    var name: String
    var texts: [String]
    var words: [String]?
    var images: [Data]?

    @Relationship var gameName: GameName
    @Relationship var majorCat: MajorCat
    @Relationship var filterTable: FilterTable?

    init(
        id: UUID = UUID(),
        name: String,
        texts: [String],
        words: [String]? = nil,
        images: [Data]? = nil,
        gameName: GameName,
        majorCat: MajorCat,
        filterTable: FilterTable? = nil
    ) {
        self.id = id
        self.name = name
        self.texts = texts
        self.words = words
        self.images = images
        self.gameName = gameName
        self.majorCat = majorCat
        self.filterTable = filterTable
    }
}
