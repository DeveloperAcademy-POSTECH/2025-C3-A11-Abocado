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
    @Environment(\.modelContext) var modelContext

    @State private var searchText: String = ""

    @Query var GameNames: [GameName]
    @State var searchedGames: [GameName] = []
    @Query private var searchGames: [SearchGames]

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
                                guard !keyword.isEmpty else { return }
                                searchedGames = GameNames.filter {
                                    $0.name.lowercased().contains(keyword)
                                        || $0.name.lowercased().hasPrefix(
                                            keyword
                                        )
                                }

                                // 중복 검색어 방지
                                let isAlreadySaved = searchGames.contains { $0.name.lowercased() == keyword }

                                if !isAlreadySaved {
                                    let newSearch = SearchGames(name: keyword)
                                    modelContext.insert(newSearch)
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
                    .background(Color.backGround)
                    .clipShape(.capsule)

                    // 최근 검색어
                    HStack {
                        Text("최근 검색어").font(.lgSemiBold)
                        Spacer()
                        Text("전체 삭제").font(.mdRegular).foregroundColor(
                            .grayNeutral40
                        )
                    }.padding()
                        .background(Color.backGround)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(
                                searchGames.sorted(by: { $0.date > $1.date }),
                                id: \.self
                            ) {
                                game in
                                SearchedCapsule(
                                    title: game.name,
                                    onTap: {},
                                    onDelete: {
                                        modelContext.delete(game)
                                    }
                                )
                            }
                        }
                    }.frame(height: 40)
                        .background(Color.backGround)

                    //TODO: 다듬기 필요
                    HStack {
                        Text("검색된 게임").font(.lgSemiBold)
                        Spacer()

                    }.padding()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(
                                searchedGames,
                                id: \.self
                            ) { game in
                                GameCardView(game: game)
                                    .aspectRatio(167 / 260, contentMode: .fit)
                            }
                        }
                    }.frame(height: 400)
                        .background(Color.backGround)

                    Spacer()
                        .background(Color.backGround)
                }
            }.padding(.vertical, 14)
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
        }.background(Color.backGround)
    }
}

#Preview {
    SearchView()
        .modelContainer(for: Item.self, inMemory: true)
}
