//
//  FilterTag.swift
//  rulebox
//
//  Created by POS on 6/1/25.
//

import SwiftData

@Model
class FilterTag {
  @Attribute(.unique) var type: String
  @Attribute(.unique) var value: String
  
  init(type: String, value: String) {
    self.type = type
    self.value = value
  }
}
