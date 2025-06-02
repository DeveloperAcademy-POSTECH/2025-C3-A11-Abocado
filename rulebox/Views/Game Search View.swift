//
//  Game Search View.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//

import SwiftUI

struct GameSearchView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                // 검색 바
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)

                    TextField("검색어를 입력하세요", text: $searchText)
                        .onSubmit {
                            // 검색하기
                        }

                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    
                }
                .padding(8)
                .background(Color(.systemGray6))
                .clipShape(.capsule)

                // 최근 검색어
                HStack {
                    Text("최근 검색어").font(.lgSemiBold)
                    Spacer()
                    Text("전체 삭제").font(.mdRegular)  //TODO: 칼라 변경 필요
                }.padding()

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Button(action: {}) {
                            Text("타일").padding(.horizontal, 8)
                        }
                        Button(action: {}) {
                            Image(systemName: "multiply")  // TODO: 아이콘 변경해야함
                        }
                    }.padding()
                        .overlay(Capsule().stroke(.gray, lineWidth: 1))  //TODO: 색변경 필요
                }
                Spacer()
            }.padding()
        }.navigationTitle("설명서 검색")
            .navigationBarTitleDisplayMode(.inline)

    }
}

#Preview {
    SearchView()
        .modelContainer(for: Item.self, inMemory: true)
}
