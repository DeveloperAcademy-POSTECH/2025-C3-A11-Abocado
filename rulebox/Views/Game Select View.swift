//
//  GameSelectView.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//

import SwiftData
import SwiftUI

// TODO: 디자인 - 닉스, 개발 - 하마의 탈을 쓴 사나
struct GameSelectView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \GameName.name) private var games: [GameName]

    var body: some View {
        NavigationStack {
            // Page Header part
            HStack {
                Text("RuleBox").font(.xlHeading)
                Spacer()
                
                NavigationLink(destination: SearchView()) {
                    searchToolbarIcon
                }

                NavigationLink(destination: BookmarkView()) {
                    bookmarkToolbarIcon
                }
            }
            .padding()
            //             genre filter 만들어야댐
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Rectangle()
                        .frame(width: 12).foregroundColor(.clear)
                    GenreCapsule(title: "전체", isSelected: false)
                    GenreCapsule(title: "가족", isSelected: true)
                    GenreCapsule(title: "파티", isSelected: false)
                    GenreCapsule(title: "전략", isSelected: true)
                    GenreCapsule(title: "추리")
                    GenreCapsule(title: "추상")
                    GenreCapsule(title: "추리")
                    GenreCapsule(title: "추상")
                    GenreCapsule(title: "추리")
                    GenreCapsule(title: "추상")
                }
            }.frame(height: 40)

            Spacer()

            // Page Body part
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Rectangle()
                        .frame(width: 6).foregroundColor(.clear)
                    ForEach(games) { game in
                        NavigationLink(destination: MainRuleBook(game: game)) {
                            VStack {
                                HStack {
                                    GenreCapsule(title: "전체", isSelected: true)
                                    GenreCapsule(title: "가족", isSelected: true)
                                    Spacer()
                                }
                                Spacer()
                                // 가나다순 이슈로 카르카손 카드가 뒤에 생기는건 일단 넘어가죠
                                HStack {
                                    Text(game.name)
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                                HStack {
                                    Text("2~5인")
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                            }
                            .padding(.horizontal, 8).padding(.vertical, 16)
                            .frame(width: 324, height: 520)
                            .background(Color.blue)
                            .cornerRadius(28)
                        }.padding(.horizontal, 6)
                    }
                }
            }
            .frame(height: 520)
            //            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            Spacer()
        }
    }
}

#Preview {
    GameSelectView()
        .modelContainer(for: GameName.self, inMemory: true)
}
