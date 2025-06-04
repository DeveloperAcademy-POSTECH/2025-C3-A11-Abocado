//
//  GameName.swift
//  rulebox
//
//  Created by POS on 6/1/25.
//

import Foundation
import SwiftData

@Model
class GameName {
    @Attribute(.unique) var id: UUID
    var name: String
    var genres: [String]
    var image: Data? = nil //image가 없는 경우는 없음. 반드시. 없음. 옵셔널 안할거야

    init(id: UUID = UUID(), name: String, genres: [String], image: Data? = nil) {
        self.id = id
        self.name = name
        self.genres = genres
        self.image = image
    }
}
