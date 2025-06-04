//
//  Searched Capsule.swift
//  rulebox
//
//  Created by Ken on 6/2/25.
//

import SwiftUI

/// 최근 검색어 표시 캡슐
struct GenreCapsule: View {
    let title: String
    var isSelected: Bool = false
    var body: some View {
        HStack {
            Button(action: {}) {

                if isSelected {
                    Text(title)
                        .font(.mdMedium)
                        .foregroundStyle(isSelected ? .white : .gray)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background(
                            Capsule().fill(Color.orange)

                        )
                }

                else {
                    Text(title)
                        .font(.mdMedium)
                        .foregroundStyle(isSelected ? .white : .gray)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background(
                            Capsule().stroke(Color.gray, lineWidth: 1)
                        )
                }

            }
        }
        .frame(height: 39)
        .padding(.vertical)
    }
}

#Preview {

    GenreCapsule(title: "하마", isSelected: false)
}
