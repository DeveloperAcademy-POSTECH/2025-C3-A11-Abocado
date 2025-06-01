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
    var text: String
    var image: Data?

    @Relationship var gameName: GameName
    @Relationship var majorCat: MajorCat
    @Relationship var filterTables: [FilterTable] = []

    init(id: UUID = UUID(), name: String, text: String, image: Data? = nil, gameName: GameName, majorCat: MajorCat) {
        self.id = id
        self.name = name
        self.text = text
        self.image = image
        self.gameName = gameName
        self.majorCat = majorCat
    }
}
