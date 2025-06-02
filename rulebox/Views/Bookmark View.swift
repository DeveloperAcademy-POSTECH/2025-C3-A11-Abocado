//
//  Bookmark View.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//

import SwiftUI
import SwiftData

// TODO: 디자인 - 하마, 개발 - 닉스
struct BookmarkView: View {
    var body: some View {
        VStack{ //navigationView
            
            ScrollView{
                HStack{//북마크시 게임이름
                    Text("GameName")
                    Spacer()
                }
                .padding(.bottom, 14)
                HStack{
                    NavigationLink(destination: ContentView()){ // 이동페이지 수정
                        HStack{
                            RoundedRectangle(cornerSize: .init(width:8, height: 8)) // rectagle()대신 소분류 이미지
                                .frame(width:56, height:56)
                                .padding(.trailing, 16)
                                
                            VStack{
                                Text("중분류")
                                Text("소분류")
                            }
                        }
                        Spacer()
                    } // ContentView()로 이동하는 NavigationLink 영역
                    
                    Rectangle()// 북마크svg
                        .frame(width:40, height:40)
                        .padding(.leading, 16)
                }
                
            }
            
        } //navigationView
        .navigationTitle("북마크")
        .navigationBarTitleDisplayMode(.inline)
        
        .padding(.horizontal, 20)
        .padding(.top, 12)
        Spacer()
    }
}

#Preview {
    BookmarkView()
}
