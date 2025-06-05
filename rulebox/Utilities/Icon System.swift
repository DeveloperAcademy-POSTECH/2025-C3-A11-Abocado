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
    Image("search")
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
    .padding(.vertical, 20)
    .padding(.horizontal, 14)

/// Toolbar bookmark Icon
var plusIcon: some View =
    Image("plus")
    .renderingMode(.template)
    .foregroundColor(.grayNeutral95)
    .padding(.vertical, 20)
    .padding(.horizontal, 14)

/// Checkbox Base Icon
public var CheckboxSelectedIcon: some View =
    Image("checkbox.selected")
    //.renderingMode(.template)
    //.foregroundColor(.grayNeutral95)
    .padding()

public var CheckboxUnSelectedIcon: some View =
    Image("checkbox.unselected")
    //.renderingMode(.template)
    //.foregroundColor(.grayNeutral95)
    .padding()
