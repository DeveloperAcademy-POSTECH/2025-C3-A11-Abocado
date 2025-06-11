//
//  Checkbox.swift
//  rulebox
//
//  Created by Elena on 6/5/25.
//

import SwiftUI

struct CheckboxBase: Identifiable {
    let id = UUID()
    let title: String
    var isChecked: Bool
}
