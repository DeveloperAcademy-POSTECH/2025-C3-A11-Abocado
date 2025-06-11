//
//  Bookmark View.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//

import SwiftUI
import SwiftData
import Lottie

// TODO: 디자인 - 하마, 개발 - 닉스
struct BookmarkView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @Query(sort: \Bookmark.createdAt, order: .reverse) var bookmarks: [Bookmark] // 북마크 불러오기
    
    var content: Content?
    
    var body: some View {
        
        //최근 추가된 북마크와 같은 gameName.id를 가진 북마크들을 한번에 모음
//        let reorderedBookmarks: [Bookmark] = {
//                guard let lastGameId = bookmarks.last?.content?.gameName.id else {
//                    return bookmarks
//                }
//
//                let lastBookmarkGame = bookmarks.filter { $0.content?.gameName.id == lastGameId }
//                let previousBookmarkGame = bookmarks.filter { $0.content?.gameName.id != lastGameId }
//                return previousBookmarkGame + lastBookmarkGame
//            }()
            
        //북마크 본문 좌우에만 padding값으로 여백 주려고 .navigationTitle("북마크") 등등은 VStack으로 분리함
        
        VStack{
            ScrollView{ //navigationView
                
                if bookmarks.isEmpty {
                    VStack{
                        Spacer()
                        Text("추가된 북마크가 없습니다.")
                            .foregroundColor(.white)
                            .font(.lgMedium)
                            .opacity(0.4)
                        Spacer()
                    }
                } else {
                    HStack{
                        Text("카르카손")
                            .font(.smHeading)
                        Spacer()
                    }
                    .padding(.bottom, 14)
                }
                
                // 최근 추가된 북마크와 같은 gameName.id를 가진 북마크들을 한번에 모으는건 되긴했는데,,
                ForEach(/*reorderedBookmarks*/ bookmarks, id: \.self) { bookmark in
                    if let content = bookmark.content {
                
                
                // 북마크 블럭
                HStack{
                    NavigationLink(destination: SubRuleModalView(content: content)){ // 이동페이지
                        HStack{
                            //content images 중 첫번째
                            //RoundedRectangle(cornerSize: .init(width:8, height: 8))
                            //Image(content.images[0])


                                let separated = content.texts[0].components(separatedBy: "***")
                                let imageFileName = separated.first ?? ""
                                
                                VStack(alignment: .leading) {
                                    if !imageFileName.isEmpty {
                                        LottieView(filename: imageFileName)
                                            .scaledToFit()
                                            .frame(width: 56, height: 56)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                            .clipped()
                                                .fixedSize()
                                    } else {
                                        RoundedRectangle(cornerRadius: 8)
                                            .frame(width: 56, height: 56)
                                        
                                    }
                                }
                            
                            
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
                        try? context.save()
                    }, label:{
                        bookmarkFilledIcon // 북마크아이콘
                            .frame(width:40, height:40)
                            //.padding(.leading, 16)
                    })
                        
                } // 북마크 블럭
                    }
                
                }
                    
                    
            } //navigationView
            .padding(.horizontal, 20)
            .padding(.top, 12)
            
            Spacer()
        }
        .background(Color.backGround)
        .navigationTitle("북마크")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarLeading){
                Button(action: {
                    dismiss()
                }, label: {
                    backButtonToolbarIcon
                })
            }
        }
            
        
    }
}

//#Preview {
//    BookmarkView()
//}
