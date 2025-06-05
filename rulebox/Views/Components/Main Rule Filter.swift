//
//  Main Rule Filter.swift
//  rulebox
//
//  Created by POS on 6/5/25.
//

import Foundation
import SwiftUI

// TODO: 디자인 컴포넌트 적용 해주세요 ㅠㅅㅠ
struct ExtensionFilterView: View {
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 2) {
                Text("게임 버전")
                Text("기본판은 필수 선택입니다")
            }
            .padding(.horizontal, 0)
            .padding(.top, 0)
            .padding(.bottom, 12)
            .frame(maxWidth: .infinity, alignment: .top)

        }
        Text("Extension Filter")
    }
}

struct PartyFilterView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .center, spacing: 2) {
                    Text("게임 인원")
                    Text("플레이 인원을 선택해주세요")
                }
                .padding(.horizontal, 0)
                .padding(.top, 0)
                .padding(.bottom, 12)
                .frame(maxWidth: .infinity, alignment: .top)
            }
        }
        Text("Party Filter")
    }
}
