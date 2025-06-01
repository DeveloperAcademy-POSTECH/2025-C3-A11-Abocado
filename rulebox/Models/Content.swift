//
//  Content.swift
//  rulebox
//
//  Created by POS on 6/1/25.
//

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

    init(id: UUID = UUID(), name: String, text: String, image: Data? = nil, gameName: GameName, majorCat: MajorCat) {
        self.id = id
        self.name = name
        self.text = text
        self.image = image
        self.gameName = gameName
        self.majorCat = majorCat
    }
}
