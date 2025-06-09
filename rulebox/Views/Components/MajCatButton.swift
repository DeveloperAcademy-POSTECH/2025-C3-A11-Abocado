//
//  MajCatButton.swift
//  rulebox
//
//  Created by POS on 6/9/25.
//
// Main Rule Book, 소분류 항목이 여러개라면 +버튼이 있고 아니라면 비어있게구성. +버튼 누르면 아코디온 열림
// onContent로 sheet띄워야하는지 관리
// hasChildren으로 expand 조건관리

import SwiftUI

struct MajCatButtonView: View {
    let cat: MajorCat
    let contents: [Content]
    @Binding var isExpanded: Bool
    @Binding var selectedContent: Content?
    @Binding var onSubRuleModalView: Bool

    var body: some View {
        let hasChildren = contents.contains { $0.name != cat.name }

        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                if hasChildren {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }

                if let direct = contents.first(where: { $0.name == cat.name }) {
                    selectedContent = direct
                }
            }) {
                HStack(spacing: 8) {
                    Text(cat.name)
                        .font(.smHeading)
                        .foregroundColor(isExpanded ? .primaryNormal : .white)

                    Spacer()

                    if hasChildren {
                        Image(isExpanded ? "minusi" : "plusi")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                    }
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .contentShape(Rectangle())
                .background(
                    RoundedCorner(
                        radius: 14,
                        corners: [.topLeft, .topRight]
                    )
                    .fill(
                        Color.primaryNormal.opacity(
                            isExpanded ? 0.1 : 0
                        )
                    )
                )
            }
            .buttonStyle(.plain)

            if isExpanded {
                ForEach(contents, id: \.id) { content in
                    Button(action: {
                        selectedContent = content
                        onSubRuleModalView = true
                    }) {
                        HStack(alignment: .center) {
                            Text(content.name)
                            Spacer()
                        }
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 14)
                    .background(
                        RoundedCorner(
                            radius: 14,
                            corners: [
                                .topLeft, .topRight,
                                .bottomLeft, .bottomRight,
                            ]
                        )
                        .fill(
                            Color.primaryNormal.opacity(
                                isExpanded ? 0.1 : 0
                            )
                        )
                    )
                    .sheet(isPresented: $onSubRuleModalView) {
                        SubRuleModalView(content: content)
                    }
                }
            } else {
                Divider()
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 18)
            }
        }
        .background(
            Group {
                if isExpanded {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            Color.primaryNormal,
                            lineWidth: 1
                        )
                }
            }
        )
    }
}
