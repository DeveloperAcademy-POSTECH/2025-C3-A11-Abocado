//
//  FilterTag.swift
//  rulebox
//
//  Created by POS on 6/1/25.
//

import Foundation
import SwiftData

@Model
class FilterTag {
    @Attribute(.unique) var id: UUID
    var value: String
    var type: String

    init(id: UUID = UUID(), value: String, type: String) {
        self.id = id
        self.value = value
        self.type = type
    }
}
