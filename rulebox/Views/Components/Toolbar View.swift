//
//  Toolbar View.swift
//  rulebox
//
//  Created by Ken on 6/4/25.
//

import SwiftUI

struct LargeToolbarView: View {
    @Environment(\.dismiss) private var dismiss

    let game: GameName

    var body: some View {
        ZStack {
            ImageConverter.imageConvert(game.image)
                .resizable()
                .scaledToFill()
                .frame(width: 393, height: 312, alignment: .top)
                .clipped()

            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.0),  // 시작은 어둡게
                    Color.black.opacity(0.7),  // 끝은 투명하게
                ]),
                startPoint: .top,
                endPoint: .bottom
            )

            VStack(alignment: .leading) {
                HStack {
                    Button(action: { dismiss() }) {
                        homeToolbarIcon
                    }
                    Spacer()
                    NavigationLink(destination: SearchView()) {
                        searchToolbarIcon
                    }
                    NavigationLink(destination: BookmarkView()) {
                        bookmarkToolbarIcon
                    }
                }.padding(.horizontal, 18).padding(.vertical, 14)

                Spacer()
                VStack {
                    HStack(spacing: 5) {
                        ForEach(
                            game.genres,
                            id: \.self
                        ) { genre in
                            GenreCapsule(title: genre, isSelected: true)
                        }
                    }
                    Text(game.name).font(.lgHeading)
                        .padding(.bottom, 18)
                }.padding(.horizontal, 20)
            }
        }
    }
}

struct FilterToolbarView: View {
    @Environment(\.dismiss) private var dismiss
    let game: GameName
    
    var body: some View {
        ZStack {
            Text(game.name)
                .font(Font.custom("Wanted Sans", size: 17).weight(.semibold))
                .foregroundColor(.white)

            HStack {
                Button(action: { dismiss() }) {
                    backButtonToolbarIcon
                }
                Spacer()
            }
        }
        .frame(height: 44)
        .padding(.top, 10)
    }
}

struct SmallToolbarView: View {
    @Environment(\.dismiss) private var dismiss

    var content: Content

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

//#Preview {
//    LargeToolbarView(
//        game: GameName(name: "ad", genres: ["asdas", "asd"])
//    )
//}
