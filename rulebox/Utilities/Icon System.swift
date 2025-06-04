//
//  Icon System.swift
//  rulebox
//
//  Created by Ken on 6/3/25.
//

import SwiftUI

/// Toolbar home Icon
var homeToolbarIcon: some View =
    Image("home")
    .renderingMode(.template)
    .foregroundColor(.white)
    .padding()
    .background(Circle().fill(Color.gray))

/// Toolbar search Icon
var searchToolbarIcon: some View =
    Image("search")
    .renderingMode(.template)
    .foregroundColor(.white)
    .padding()
    .background(Circle().fill(Color.gray))

/// Toolbar bookmark Icon
var bookmarkToolbarIcon: some View =
    Image("bookmark")
    .renderingMode(.template)
    .foregroundColor(.white)
    .padding()
    .background(Circle().fill(Color.gray))

/// Toolbar bookmark Icon
var bookmarkIcon: some View =
    Image("bookmark")
    .renderingMode(.template)
    .foregroundColor(.grayNeutral95)
    .padding()

/// Toolbar bookmark Icon
var bookmarkFilledIcon: some View =
    Image("bookmark.fill")
    .renderingMode(.template)
    .foregroundColor(.primaryNormal)
    .padding()
