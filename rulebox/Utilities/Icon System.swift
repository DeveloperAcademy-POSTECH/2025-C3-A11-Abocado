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
    .background(Circle().fill(Color.gray).frame(width: 40, height: 40))
    .frame(width: 40, height: 40)

/// Toolbar search Icon
var searchToolbarIcon: some View =
    Image("Search") // 대소문자 구분해야됨
    .renderingMode(.template)
    .foregroundColor(.white)
    .padding()
    .background(Circle().fill(Color.gray).frame(width: 40, height: 40))

/// Toolbar bookmark Icon
var bookmarkToolbarIcon: some View =
    Image("bookmark")
    .renderingMode(.template)
    .foregroundColor(.white)
    .padding()
    .background(Circle().fill(Color.gray).frame(width: 40, height: 40))
    .frame(width: 40, height: 40)

/// Toolbar bookmark Icon
public var bookmarkIcon: some View =
    Image("bookmark")
    .renderingMode(.template)
    .foregroundColor(.grayNeutral95)
    .padding()

/// Toolbar bookmark Icon
public var bookmarkFilledIcon: some View =
    Image("bookmark.fill")
    .renderingMode(.template)
    .foregroundColor(.primaryNormal)
    .padding()

/// Toolbar bookmark Icon
var minusIcon: some View =
    Image("minus")
    .renderingMode(.template)
    .foregroundColor(.primaryNormal)
    .padding()

/// Toolbar bookmark Icon
var plusIcon: some View =
    Image("plus")
    .renderingMode(.template)
    .foregroundColor(.grayNeutral95)
    .padding()
