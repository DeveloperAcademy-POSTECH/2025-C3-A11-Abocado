//
//  GameName.swift
//  rulebox
//
//  Created by POS on 6/1/25.
//

import SwiftData

@Model
class GameName {
  @Attribute(.unique) var name: String
  var majorCats: [MajorCat] = []
  
  init(name: String) {
    self.name = name
  }
}
