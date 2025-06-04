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
    @StateObject private var vm = GameSelectVM()
    
    var body: some View {
        NavigationStack {
            VStack {
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

                // Genre filter part
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(["전체"] + GenreList.allGenres, id: \.self) { genre in
                            GenreCapsule(title: genre, isSelected: vm.selectedGenre == genre) {
                                vm.selectedGenre = genre
                                print("\(genre) is selected")
                            }
                        }
                    }
                }
                .frame(height: 40)

                Spacer(minLength: 20)

                // Page Body part
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Rectangle().frame(width: 6).foregroundColor(.clear)

                        ForEach(vm.filterGames(from: games)) { game in
                            GameCardView(game: game, selectedGenre: vm.selectedGenre)
                        }
                    }
                }
                .frame(height: 520)

                Spacer()
            }
        }
    }
}


struct GameCardView: View {
    let game: GameName
    let selectedGenre: String

    var body: some View {
        NavigationLink(destination: MainRuleBook(game: game)) {
            VStack {
                HStack(alignment: .top) {
                    ForEach(game.genres, id: \.self) { genre in
                        GenreCapsule(title: genre, isSelected: selectedGenre == "전체" || selectedGenre == genre)
                    }
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
                    Text("2~5인") // 아 여기도 나중에 바꿔야되네
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            .padding(.horizontal, 8).padding(.vertical, 16)
            .frame(width: 324, height: 520)
            .background(
                ImageConverter.imageConvert(game.image)
            )
            .cornerRadius(28)
        }
        .padding(.horizontal, 6)
    }
}

#Preview {
    GameSelectView()
        .modelContainer(for: GameName.self, inMemory: true)
}
