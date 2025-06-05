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
    @Environment(\.modelContext) private var modelContext
    @Query private var games: [SearchGames]

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
                                let trimmedText = searchText.trimmingCharacters(
                                    in: .whitespacesAndNewlines
                                )
                                guard !trimmedText.isEmpty else { return }
                                let newSearch = SearchGames(name: trimmedText)
                                modelContext.insert(newSearch)
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
                    VStack(spacing: 16) {
                        HStack {
                            Text("최근 검색어").font(.lgSemiBold)
                            Spacer()
                            Text("전체 삭제").font(.mdRegular)
                                .foregroundColor(.grayNeutral70).onTapGesture {
                                    for game in games {
                                        modelContext.delete(game)
                                    }
                                }
                        }.padding(.horizontal, 0)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(
                                    games.sorted(by: { $0.date > $1.date }),
                                    id: \.self
                                ) {
                                    game in
                                    SearchedCapsule(
                                        title: game.name,
                                        onDelete: {
                                            modelContext.delete(game)
                                        }
                                    )
                                }
                            }
                        }.frame(height: 40)
                    }.padding(.vertical, 14)
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
        .modelContainer(for: SearchGames.self, inMemory: true)
}
