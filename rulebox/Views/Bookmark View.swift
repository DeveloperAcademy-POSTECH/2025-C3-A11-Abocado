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
    @Environment(\.modelContext) var context
    @Query var bookmarks: [Bookmark] // 북마크 불러오기
    
    var body: some View {
            
        ScrollView{ //navigationView
                HStack{//북마크시 게임이름
                    Text("GameName").font(.smHeading)
                    Spacer()
                }
                .padding(.bottom, 14)
            
            
            ForEach(bookmarks, id: \.id) { bookmark in
                if let content = bookmark.content {
                    HStack{ // 북마크 블럭
                        NavigationLink(destination: SubRuleModalView(content: content)){ // 이동페이지
                            HStack{
                                RoundedRectangle(cornerSize: .init(width:8, height: 8)) // rectagle()대신 소분류 이미지
                                    .frame(width:56, height:56)
                                    .padding(.trailing, 16)
                                    
                                VStack(alignment: .leading){
                                    Text(content.majorCat.name)// 중분류
                                        .font(.mdRegular)
                                        //.foregroundColor(.white)
                                        .opacity(0.46)
                                    Text(content.name) //소분류
                                        .font(.lgMedium)
                                }
                            }
                            Spacer()
                        } // SubRuleModalView()로 이동하는 NavigationLink 영역
                        
                        Button(action:{
                            context.delete(bookmark)
                        }){
                            Image(systemName: "bookmark.fill") // 북마크아이콘 교체해야함
                                .resizable()
                                .frame(width:40, height:40)
                                .padding(.leading, 16)
                            
                        }
                            
                    } // 북마크 블럭
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
