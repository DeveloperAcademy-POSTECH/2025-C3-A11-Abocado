//
//  Game Search View.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//

import SwiftData
import SwiftUI

struct GameSearchView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var searchText: String = ""

    @Query var GameNames: [GameName]

    @State var searchedGames: [GameName] = []

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
                                let keyword = searchText.trimmingCharacters(
                                    in: .whitespacesAndNewlines
                                ).lowercased()
                                searchedGames = GameNames.filter {
                                    $0.name.lowercased().contains(keyword)
                                        || $0.name.lowercased().hasPrefix(
                                            keyword
                                        )
                                }
                                
                                

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
                        HStack {

                            ForEach(searchedGames, id: \.self) {
                                game in
                                SearchedCapsule(title: game.name)
                            }
                        }

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
