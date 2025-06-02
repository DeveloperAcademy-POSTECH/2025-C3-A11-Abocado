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
                Text("RuleBox")  // Font 수정해주세요

                Spacer()

                NavigationLink(destination: SearchView()) {
                    Image(systemName: "magnifyingglass")  // image 수정해주세요
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(Color.blue))
                }

                NavigationLink(destination: BookmarkView()) {
                    Image(systemName: "bookmark.fill")  // image 수정해주세요
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(Color.orange))
                }
            }
            .padding()
            
            Spacer()
            
            // Page Body part
            TabView { // 생긴거 전면수정해주세요
                ForEach(games) { game in
                    NavigationLink(destination: MainRuleBook(game: game)) {
                        VStack {
                            Text(game.name)
                                .foregroundColor(.white)
                        }
                        .frame(width: 324, height: 520)
                        .background(Color.blue)
                        .cornerRadius(15)
                        .padding()
                    }
                }
            }
            .frame(height: 520)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            
            Spacer()
        }
    }
}

#Preview {
    GameSelectView()
        .modelContainer(for: GameName.self, inMemory: true)
}
