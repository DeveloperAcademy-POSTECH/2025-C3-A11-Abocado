//
//  FilterTable.swift
//  rulebox
//
//  Created by POS on 6/1/25.
//

import Foundation
import SwiftData

@Model
class FilterTable {
    @Attribute(.unique) var id: UUID
    var targetID: UUID
    
    @Relationship var filtertags: [FilterTag]
    @Relationship var content: Content?

    init(id: UUID = UUID(), targetID: UUID, filtertags: [FilterTag]) {
        self.id = id
        self.targetID = targetID
        self.filtertags = filtertags
    }
}
