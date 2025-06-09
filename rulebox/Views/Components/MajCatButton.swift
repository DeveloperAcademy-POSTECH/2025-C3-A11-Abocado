//
//  MajCatButton.swift
//  rulebox
//
//  Created by POS on 6/9/25.
//
// Main Rule Book, 소분류 항목이 여러개라면 +버튼이 있고 아니라면 비어있게구성. +버튼 누르면 아코디온 열림
// hasChildren으로 조건관리

import SwiftUI

struct MajCatButtonView: View {
    let cat: MajorCat
    let contents: [Content]
    @Binding var isExpanded: Bool
    @Binding var selectedContent: Content?
    
    var hasChildren: Bool {
        contents.contains { $0.name != cat.name }
    }
    
    var body: some View {
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
                        .foregroundColor(
                            isExpanded ? .primaryNormal : .white
                        )
                    
                    Spacer()
                    
                    if hasChildren {
                        if isExpanded {
                            Image("minusi")
                                .renderingMode(.template)
                                .foregroundColor(.white)
                        } else {
                            Image("plusi")
                                .renderingMode(.template)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            
            if isExpanded && hasChildren {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(contents.filter { $0.name != cat.name }, id: \.id) { content in
                        Button(action: {
                            selectedContent = content
                        }) {
                            Text(content.name)
                                .font(.body)
                                .foregroundColor(.primary)
                                .padding(.leading, 16)
                        }
                    }
                    .padding(.top, 8)
                }
            }
        }
    }
}

