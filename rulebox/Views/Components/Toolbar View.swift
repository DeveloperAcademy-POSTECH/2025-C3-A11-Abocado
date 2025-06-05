//
//  Toolbar View.swift
//  rulebox
//
//  Created by Ken on 6/4/25.
//

import SwiftUI

struct LargeToolbarView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var isBookmarked: Bool
    var content: Content

    let game: GameName

    var body: some View {
        ZStack {
            ImageConverter.imageConvert(game.image)
                .resizable()
                .frame(width: 393, height: 393)
            VStack(alignment: .leading) {
                HStack {
                    Button(action: { dismiss() }) {
                        homeToolbarIcon
                    }
                    Spacer()
                    NavigationLink(destination: SearchView()) {
                        searchToolbarIcon
                    
                        NavigationLink(destination: BookmarkView(isBookmarked: $isBookmarked, content: content)) {
                        bookmarkToolbarIcon
                    }
                }.padding(.horizontal, 18).padding(.vertical, 14)

                Spacer()
                ForEach(
                    game.genres,
                    id: \.self
                ) { genre in
                    GenreCapsule(title: genre, isSelected: true)
                }
                Text(game.name).font(.lgSemiBold)
            }
        }
    }
}

struct SmallToolbarView: View {
    @Environment(\.dismiss) private var dismiss

    let game: GameName

    var body: some View {
        ZStack {
            ImageConverter.imageConvert(game.image)
                .resizable()
                .frame(width: 393, height: 68)
            Color.clear
                .background(.ultraThinMaterial)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                HStack {
                    Button(action: { dismiss() }) {
                        homeToolbarIcon
                    }
                    Spacer()
                    VStack(spacing: 4) {
                        Text(game.name)
                            .font(.mdMedium)
                        ForEach(
                            game.genres,
                            id: \.self
                        ) { genre in
                            Text(genre)
                                .font(.smRegular)
                        }
                    }

                    Spacer()
                    NavigationLink(destination: SearchView()) {
                        searchToolbarIcon
                    }
                    NavigationLink(destination: BookmarkView()) {
                        bookmarkToolbarIcon
                    }
                }.padding(.horizontal, 18).padding(.vertical, 14)

            }
        }
    }

}

#Preview {
    LargeToolbarView(
        game: GameName(name: "ad", genres: ["asdas", "asd"])
    )
}
