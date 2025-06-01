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
    var genre: String

    init(id: UUID = UUID(), name: String, genre: String) {
        self.id = id
        self.name = name
        self.genre = genre
    }
}
