//
//  MajorCat.swift
//  rulebox
//
//  Created by POS on 6/1/25.
//

import Foundation
import SwiftData

@Model
class MajorCat {
    @Attribute(.unique) var id: UUID
    var name: String
    var order: Int

    init(id: UUID = UUID(), name: String, order: Int) {
        self.id = id
        self.name = name
        self.order = order
    }
}
