//
//  Icon System.swift
//  rulebox
//
//  Created by Ken on 6/3/25.
//

import SwiftUI

/// Toolbar home Icon
var homeIcon: some View =
    Image("home")
    .renderingMode(.template)
    .foregroundColor(.white)
    .padding()
    .background(Circle().fill(Color.gray))

/// Toolbar search Icon
var searchIcon: some View =
    Image("search")
    .renderingMode(.template)
    .foregroundColor(.white)
    .padding()
    .background(Circle().fill(Color.gray))

/// Toolbar bookmark Icon
var bookmarkIcon: some View =
    Image("bookmark")
    .renderingMode(.template)
    .foregroundColor(.white)
    .padding()
    .background(Circle().fill(Color.gray))
