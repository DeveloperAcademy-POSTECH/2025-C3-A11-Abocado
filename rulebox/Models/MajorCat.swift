//
//  MajorCat.swift
//  rulebox
//
//  Created by POS on 6/1/25.
//

import SwiftData

@Model
class MajorCat {
  @Attribute(.unique) var name: String
  var gameName: GameName
  var subCats: [SubCat] = []
  
  init(name: String, gameName: GameName) {
    self.name = name
    self.gameName = gameName
  }
}
