//
//  Typo System.swift
//  rulebox
//
//  Created by Ken on 5/30/25.
//

import SwiftUI

enum WantedSans: String, CaseIterable {
    case regular = "WantedSans-Regular"
    case medium = "WantedSans-Medium"
    case semiBold = "WantedSans-SemiBold"
}

extension Font {
    static func wanted(_ type: WantedSans, size: CGFloat) -> Font {
        .custom(type.rawValue, size: size)
    }
    
    //MARK: - Headings
    static let xlHeading: Font = .wanted(.semiBold, size: 34)
    static let lgHeading: Font = .wanted(.semiBold, size: 28)
    static let mdHeading: Font = .wanted(.semiBold, size: 24)
    static let smHeading: Font = .wanted(.semiBold, size: 20)
    
    //MARK: - Body
    static let lgSemiBold: Font = .wanted(.semiBold, size: 17)
    static let lgRegular: Font = .wanted(.regular, size: 17)
    static let lgMedium: Font = .wanted(.medium, size: 17)
    
    static let mdSemiBold: Font = .wanted(.semiBold, size: 14)
    static let mdRegular: Font = .wanted(.regular, size: 14)
    static let mdMedium: Font = .wanted(.medium, size: 14)
    
    static let smSemiBold: Font = .wanted(.semiBold, size: 12)
    static let smRegular: Font = .wanted(.regular, size: 12)
    static let smMedium: Font = .wanted(.medium, size: 12)
    
    
    
}
