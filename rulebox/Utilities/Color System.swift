//
//  Color System.swift
//  rulebox
//
//  Created by Ken on 5/30/25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = Double((rgb & 0xFF0000) >> 16) / 255
        let g = Double((rgb & 0x00FF00) >> 8) / 255
        let b = Double(rgb & 0x0000FF) / 255

        self.init(red: r, green: g, blue: b)
    }
    //MARK: - Opacity
    static let opacity5 = 5
    static let opacity10 = 10
    static let opacity20 = 20
    static let opacity25 = 25
    static let opacity85 = 85
    
    //MARK: - Opacity
    static let atomicOpacity5 = Color.white.opacity(0.05)
    static let atomicOpacity10 = Color.white.opacity(0.1)
    static let atomicOpacity20 = Color.white.opacity(0.2)
    static let atomicOpacity25 = Color.white.opacity(0.25)
    static let atomicOpacity85 = Color.white.opacity(0.85)

    //MARK: - Others
    static let backGroundCol: Color = Color(hex: "#1D1E20")

    //MARK: - Semantic Color
    static let primaryNormal: Color = Color(hex: "#FF6200")
    static let primaryStrong: Color = Color(hex: "#EB5A00")
    static let primaryHeavy: Color = Color(hex: "#D15000")
    
    
    static let atomicCommon: Color = Color(hex: "#D15000")
    //MARK: - Gray
    static let grayNeutral99: Color = Color(hex: "#F7F7F7")
    static let grayNeutral95: Color = Color(hex: "#DCDCDC")
    static let grayNeutral90: Color = Color(hex: "#C4C4C4")
    static let grayNeutral80: Color = Color(hex: "#B0B0B0")
    static let grayNeutral70: Color = Color(hex: "#9B9B9B")
    static let grayNeutral60: Color = Color(hex: "#8A8A8A")
    static let grayNeutral50: Color = Color(hex: "#737373")
    static let grayNeutral40: Color = Color(hex: "#5C5C5C")
    static let grayNeutral30: Color = Color(hex: "#474747")
    static let grayNeutral20: Color = Color(hex: "#2A2A2A")
    static let grayNeutral10: Color = Color(hex: "#171717")
    static let grayNeutral05: Color = Color(hex: "#0F0F0F")
    static let grayNeutral00: Color = Color(hex: "#000000")

}
