//
//  Searched Capsule.swift
//  rulebox
//
//  Created by Ken on 6/2/25.
//

import SwiftUI

/// 최근 검색어 표시 캡슐
struct SearchedCapsule: View {
    let title: String
    var body: some View {
        HStack {
            Button(action: {}) {
                Text(title).font(.mdMedium).foregroundColor(.grayNeutral99)
            }.padding(.vertical, 6).padding(.leading, 12)
            Button(action: {}) {
                Image("cross").foregroundColor(.grayNeutral60)
            }.frame(width: 24, height: 24).padding(.vertical, 6)

        }
        .overlay(Capsule().stroke(Color.grayNeutral30, lineWidth: 1)).frame(
            height: 34
        )
        .padding(.vertical)
    }
}

#Preview {
    SearchedCapsule(title: "하마")
}
