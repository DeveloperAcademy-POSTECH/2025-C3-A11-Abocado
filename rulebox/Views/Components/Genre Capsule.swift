//
//  Searched Capsule.swift
//  rulebox
//
//  Created by Ken on 6/2/25.
//

import SwiftUI

/// 장르 표시 캡슐
struct GenreCapsule: View {
    let title: String
    var isSelected: Bool = false
    var action: (() -> Void)? = nil  // 버튼 액션은 장르캡슐 내부에서 처리

    var verticalPadding: CGFloat = 6
    var horizontalPadding: CGFloat = 12

    var body: some View {
        HStack {
            Button(action: {
                action?()  // 버튼 액션은 장르캡슐 내부에서 처리. 일단 외부에서 액션 입력해주는걸로
            }) {
                if isSelected {
                    Text(title)
                        .font(.mdMedium)
                        .foregroundStyle(isSelected ? .white : .gray)
                        .padding(.vertical, verticalPadding)
                        .padding(.horizontal, horizontalPadding)
                        .background(
                            Capsule().fill(Color.primaryNormal)

                        )
                }

                else {
                    Text(title)
                        .font(.mdMedium)
                        .foregroundStyle(isSelected ? .white : .gray)
                        .padding(.vertical, verticalPadding)
                        .padding(.horizontal, horizontalPadding)
                        .background(
                            Capsule().stroke(Color.grayNeutral95, lineWidth: 1)
                        )
                }

            }
        }
        .frame(height: 39)
        .padding(.vertical)
        .background(Color.clear)  // 버튼 터치 안됨이슈로 추가해본 한 줄
    }
}

#Preview {
    GenreCapsule(title: "하마", isSelected: false)
}
