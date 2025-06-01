//
//  SubCat.swift
//  rulebox
//
//  Created by POS on 6/1/25.
//

import SwiftData

@Model
class SubCat {
  @Attribute(.unique) var name: String
  var majorCat: MajorCat
  var contents: [Content] = []
  
  init(name: String, majorCat: MajorCat) {
    self.name = name
    self.majorCat = majorCat
  }
}
