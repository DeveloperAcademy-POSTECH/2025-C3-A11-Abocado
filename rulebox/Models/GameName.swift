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

    init(id: UUID = UUID(), name: String, genres: [String]) {
        self.id = id
        self.name = name
        self.genres = genres
    }
}
