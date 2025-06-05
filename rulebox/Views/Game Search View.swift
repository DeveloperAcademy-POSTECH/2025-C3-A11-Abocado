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
            ScrollView {
                VStack(alignment: .leading) {
                    // 검색 바
                    HStack {
                        Image("search")  //대소문자 구분해야됨 -사나
                            .renderingMode(.template)
                            .foregroundColor(.white)

                        TextField("검색어를 입력하세요", text: $searchText)
                            .onSubmit {
                                // 검색하기
                            }

                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                            }) {
                                Image("cancel")
                                    .renderingMode(.template)
                                    .foregroundColor(.grayNeutral80)
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
                        Text("전체 삭제").font(.mdRegular).foregroundColor(
                            .grayNeutral40
                        )
                    }.padding()

                    ScrollView(.horizontal, showsIndicators: false) {
                        SearchedCapsule(title: "검색어1")
                        SearchedCapsule(title: "검색어2")
                        SearchedCapsule(title: "검색어3")
                        SearchedCapsule(title: "검색어4")
                        SearchedCapsule(title: "검색어5")
                    }
                    Spacer()
                }
                .padding()
            }
            .ignoresSafeArea(.keyboard) 
        }
        .navigationTitle("게임 검색")
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    backButtonToolbarIcon
                }
            }
        }
    }
}

#Preview {
    SearchView()
        .modelContainer(for: Item.self, inMemory: true)
}
