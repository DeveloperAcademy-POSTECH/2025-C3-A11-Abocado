//
//  Game Select View.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//

import SwiftData
import SwiftUI

// TODO: 디자인 - 닉스, 개발 - 하마
struct GameSelectView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationStack {
            VStack(spacing: 60) {
                NavigationLink(destination: SearchView()) {
                    Text("검색 페이지")
                }
                Button(action: {}) {
                    Text("책갈피")
                }
                Button(action: {}) {
                    Text("버튼")
                }
                NavigationLink(destination: MainRuleBook()) {
                    Text("카르카손")
                }
                Button(action: {
                    
                }) {
                    Text("게임 2")
                }
            }.navigationTitle("설명서 선택")
        }
    }
}

#Preview {
    GameSelectView()
        .modelContainer(for: Item.self, inMemory: true)
}
