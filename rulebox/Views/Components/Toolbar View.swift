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

struct ContentToolbarView: View {
    @Environment(\.dismiss) private var dismiss
    var content: Content
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack{
                Color.white.opacity(0.2)
                    .blur(radius: 50)
                    .ignoresSafeArea(edges: .top)
                HStack {
                    Button(action: { dismiss() }) {
                        backButtonToolbarIcon
                    }
                    Spacer()
                    NavigationLink(destination: SearchView()) {
                        searchToolbarIcon
                    }
                    NavigationLink(destination: BookmarkView()) {
                        bookmarkToolbarIcon
                    }
                }.padding(.horizontal, 18).padding(.vertical, 14)
                
                Text(content.majorCat.name)
                    .font(.lgMedium)
                    .foregroundColor(.white)
            }.frame(height: 68)
        }
        
    }
}

//#Preview {
//    LargeToolbarView(
//        game: GameName(name: "ad", genres: ["asdas", "asd"])
//    )
//}
