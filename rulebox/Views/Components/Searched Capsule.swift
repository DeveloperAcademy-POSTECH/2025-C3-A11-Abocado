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
                Text(title).font(.mdMedium).foregroundStyle(.gray)  // 색변경 필요
            }.padding(.vertical, 6).padding(.leading, 12)
            Button(action: {}) {
                Image(systemName: "multiply").foregroundColor(.gray)  // TODO: 아이콘 변경해야함
            }.frame(width: 24, height: 24).padding(.vertical, 6)

        }
        .overlay(Capsule().stroke(.gray, lineWidth: 1)).frame(height: 34)
        .padding(.vertical)
    }
}

#Preview {
    SearchedCapsule(title: "하마")
}
