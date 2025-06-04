//
//  Toolbar View.swift
//  rulebox
//
//  Created by Ken on 6/4/25.
//

import SwiftUI

struct ToolbarView: View {
    @Environment(\.dismiss) private var dismiss

    let game: GameName

    @State var isExapnded: Bool = false

    var body: some View {
        if isExapnded {
            VStack {
                ForEach(
                    game.genres,
                    id: \.self
                ) { genre in
                    GenreCapsule(title: genre, isSelected: true)
                }
            }
            .background(
                ImageConverter.imageConvert(game.image)?.resizable()
                    .scaledToFill().frame(
                        height: 400
                    )
            )
        } else {

            ZStack {
                Color.clear
                    .background(.ultraThinMaterial)
                    .ignoresSafeArea()
                    .background(
                        ImageConverter.imageConvert(game.image)
                    )
            }
        }
    }
}

#Preview {
    ToolbarView(
        game: GameName(name: "ad", genres: ["asdas", "asd"])
    )
}
