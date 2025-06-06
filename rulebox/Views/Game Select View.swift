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
                    HStack(spacing: 8) {
                        Rectangle().frame(width: 10).foregroundColor(.clear)
                        ForEach(["전체"] + GenreList.allGenres, id: \.self) {
                            genre in
                            GenreCapsule(
                                title: genre,
                                isSelected: vm.selectedGenre == genre
                            ) {
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
                    HStack(spacing: 12) {
                        Rectangle().frame(width: 6).foregroundColor(.clear)
                        ForEach(vm.filterGames(from: games)) { game in
                            GameCardView(
                                game: game,
                                selectedGenre: vm.selectedGenre
                            )
                        }
                    }
                }
                .frame(height: 520)
                
                Spacer()
            }
            
            
            NavigationLink(destination: AbocadoTimer()) {
                Circle()
                    .fill(.clear)
                    .frame(width: 44, height: 44)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            
        }
    }
}

#Preview {
    GameSelectView()
        .modelContainer(for: GameName.self, inMemory: true)
}
