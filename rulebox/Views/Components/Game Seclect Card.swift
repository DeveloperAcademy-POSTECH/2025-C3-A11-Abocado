//
//  Game Seclect Card.swift
//  rulebox
//
//  Created by Ken on 6/5/25.
//

import SwiftUI

struct GameCardView: View {
    let game: GameName

    @State private var showToolTip = false

    var body: some View {
        VStack {
            if game.name == "카르카손" {
                // ✅ NavigationLink → 정상 이동
//                NavigationLink(destination: MainRuleBook(game: game)) {
                NavigationLink(destination: FilterView(game: game)) {
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
                }
                .padding(.horizontal, 22)
                .padding(.top, 26)
                .padding(.bottom, 32)
                .frame(width: 324, height: 520)
                .background(
                    ImageConverter.imageConvert(game.image)
                )
                .cornerRadius(28)

            } else {
                // ✅ Button → 현재 페이지 유지 + showToolTip 처리
                Button {
                    showToolTip = true
                } label: {
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
        .overlay(
            Group {
                if showToolTip {
                    VStack {
                        Spacer()
                        Text("현재 지원하지 않는 게임입니다.")
                            .padding()
                            .background(Color.black.opacity(0.8))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .padding(.bottom, 40)
                            .transition(
                                .move(edge: .bottom).combined(with: .opacity)
                            )
                            .animation(.easeInOut, value: showToolTip)
                    }
                    .onAppear {
                        // 자동으로 2초 후 닫힘
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showToolTip = false
                        }
                    }
                }
            }
        )
    }
}
