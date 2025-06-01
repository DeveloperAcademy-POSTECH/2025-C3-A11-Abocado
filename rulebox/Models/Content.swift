//
//  Content.swift
//  rulebox
//
//  Created by POS on 6/1/25.
//

import SwiftData

@Model
class Content {
  var name: String
  var text: String
  var subCat: SubCat
  var filterTags: [FilterTag] = []
  //var imageData: Data? 이미지
  
  init(name: String, text: String, subCat: SubCat, filterTags: [FilterTag] = [],
       //imageData: Data? = nil // image 데이터 처리 고려해봐야함
  ) {
    self.name = name
    self.text = text
    self.subCat = subCat
    self.filterTags = filterTags
    //self.imageData = imageData
  }
}
