//
//  Bookmark.swift
//  rulebox
//
//  Created by SYJ on 6/3/25.
//

import SwiftData
import Foundation


//북마크 클래스
@Model
class Bookmark {
    var id:UUID
    var createdAt:Date // 정렬할때
    
    @Relationship var content: Content?

    init(content: Content?) {
        self.id = UUID()
        self.content = content
        self.createdAt = Date()
    }
}
