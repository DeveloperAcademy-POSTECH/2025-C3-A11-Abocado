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
        ZStack {
            VStack(alignment: .leading, spacing: 8) {
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
            .padding(.horizontal, 20)

            if isExpanded {
                VStack(alignment: .leading, spacing: 10) {
                    Text("안에 들어갈 내용 1")
                    Text("안에 들어갈 내용 2")
                }
                .font(.lgRegular)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.bottom, 18)
            }
            }
            .background(isExpanded ? Color.primaryNormal.opacity(0.15) : Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.primaryNormal, lineWidth: isExpanded ? 1 : 0)
            )
            .cornerRadius(16)
            .padding(.horizontal, 14)
            
        }
    }
}


#Preview {
    Accordion()
       .background(.black)
}
