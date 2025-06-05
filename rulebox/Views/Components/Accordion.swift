//
//  Accordian.swift
//  rulebox
//
//  Created by 김지윤 on 6/5/25.
//

import SwiftUI

struct Accordion: View {
    @State private var isExpanded: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // 헤더: 텍스트 + 아이콘
            HStack {
                Text("섹션 제목")
                    .font(.smHeading)
                    .foregroundColor(isExpanded ? Color.primaryNormal : .white)

                Spacer()

                Image(systemName: isExpanded ? "chevron.up" : "chevron.down") // TODO: plus,minus Icon 변경 필요
                    .resizable()
                    .frame(width: 16, height: 8)
                    .foregroundColor(.white)
                    .onTapGesture {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }
            }
            .padding(.vertical, 20)

            if isExpanded {
                VStack(alignment: .leading, spacing: 10) {
                    Text("안에 들어갈 내용 1")
                    Text("안에 들어갈 내용 2")
                }
                .font(.lgRegular)
                .foregroundColor(.white)
            }
        }
        .padding()
    }
}

#Preview {
    Accordion()
       .background(.black)
}
