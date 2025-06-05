//
//  Game Seclect Card.swift
//  rulebox
//
//  Created by Ken on 6/5/25.
//

import SwiftUI

struct GameCardView: View {
    let game: GameName
    let selectedGenre: String

    var body: some View {
        NavigationLink(destination: MainRuleBook(game: game)) {
            VStack {
                HStack(alignment: .top) {
                    ForEach(game.genres, id: \.self) { genre in
                        GenreCapsule(
                            title: genre,
                            isSelected: true,
                            verticalPadding: 4,
                            horizontalPadding: 8
                        )
                    }
                    Spacer()
                }.padding(.all, 0)

                Spacer()
                // 가나다순 이슈로 카르카손 카드가 뒤에 생기는건 일단 넘어가죠
                HStack {
                    Text(game.name)
                        .font(.lgHeading)

                        .foregroundColor(.white)
                    Spacer()
                }
                HStack {
                    Text("2~5인")  // 아 여기도 나중에 바꿔야되네 filterTag가 contents에 있으니까 이걸 ..... ... ... ... 가져와? 어디서 계산해서 매핑해두면 안되려나
                        .font(.lgRegular)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            .padding(.horizontal, 22)
            .padding(.top, 26)
            .padding(.bottom, 32)
            .frame(width: 324, height: 520)
            .background(
                ImageConverter.imageConvert(game.image)
            )
            .cornerRadius(28)
        }
    }
}
