//
//  MajorCat.swift
//  rulebox
//
//  Created by POS on 6/1/25.
//

import Foundation
import SwiftData

@Model
class SearchGames {
    @Attribute(.unique) var id: UUID
    var name: String
    var date: Date
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
        self.date = Date()
    }
}
