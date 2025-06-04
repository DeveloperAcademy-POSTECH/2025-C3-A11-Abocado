//
//  ImageConverter.swift
//  rulebox
//
//  Created by POS on 6/4/25.
//

import Foundation
import SwiftUI

// Data type을 image type로 변경해줘야댐... 
struct ImageConverter {
    static func imageConvert(_ data: Data?) -> Image {
        guard let data = data, let uiImage = UIImage(data: data) else {
            return Image(systemName: "exclamationmark.triangle")
        }
        return Image(uiImage: uiImage)
    }
}
