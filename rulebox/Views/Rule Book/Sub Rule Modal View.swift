//
//  Sub Rule Page.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//

import SwiftData
import SwiftUI

// 모달 페이지입니다.
struct SubRuleModalView: View {
    @State private var showToast = false

    @Environment(\.modelContext) var context
    @State var isBookmarkedState = false
    //모든 북마크 불러오기
    @Query var bookmarks: [Bookmark]

    //현재 content가 북마크 되었는지 확인
    var content: Content
    var isBookmarked: Bool {
        bookmarks.contains { $0.content?.id == content.id }
    }

    var loremIpsum: String {
        if let url = Bundle.main.url(
            forResource: "lorem", withExtension: "txt", subdirectory: "Data"),
            let contents = try? String(contentsOf: url)
        {
            return contents
        }
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    VStack(alignment: .leading) {
                        Text("MajorCat Name")
                            .font(.lgRegular)
                            .foregroundColor(.grayNeutral70)
                        HStack{
                            Text("상세설명 제목")
                                .font(.mdHeading)
                                .foregroundColor(.white)
                            Spacer()
                            // 북마크
                            Button(
                                action: {
                                    //북마크 해제
                                    if isBookmarkedState {
                                        //북마크 제거
                                        if let bookmark = bookmarks.first(where: {
                                            $0.content?.id == content.id
                                        }) {
                                            context.delete(bookmark)
                                        }
                                    } else {
                                        let newBookmark = Bookmark(content: content)
                                        context.insert(newBookmark)
                                        
                                        showToast = true
                                        DispatchQueue.main.asyncAfter(
                                            deadline: .now() + 2
                                        ) {
                                            showToast = false
                                        }
                                    }
                                    //상태토글
                                    isBookmarkedState.toggle()
                                },
                                label: {
                                    // 북마크아이콘
                                    (isBookmarkedState
                                        ? AnyView(bookmarkFilledIcon)
                                        : AnyView(bookmarkIcon))
                                        .frame(width: 40, height: 40)
                                })
                            .onAppear {
                                isBookmarkedState = isBookmarked
                            }
                        }
                    }
                    
                    //이미지영역
                    HStack {
                        Spacer()
                        Text("이미지가 들어갈 거에요")
                        Spacer()
                    }
                    .padding(.bottom, 12)
                    
                    //설명영역
                    Text(loremIpsum)
                        .foregroundColor(.grayNeutral99)
                        .font(.lgRegular)
                        .padding(.bottom, 34)
                }
                .padding(.horizontal, 20)
                .padding(.top, 50)
                .overlay(
                    Group {
                        if showToast {
                            Text("북마크에 추가되었습니다")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .transition(.opacity)
                        }
                    },
                    alignment: .bottom
                )
            }
            .safeAreaInset(edge: .bottom){
                
                HStack {
                    NavigationLink(destination: SearchView()) {
                        HStack {
                            Image("caret.left")
                                .tint(.white)
                            Text("이전 페이지")
                                .font(.lgRegular)
                        }
                    }
                    Spacer()
                    NavigationLink(destination: SearchView()) {
                        HStack {
                            Text("다음 페이지")
                                .font(.lgRegular)
                            Image("caret.left").rotationEffect(.degrees(180))
                                .tint(.white)
                        }
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .padding(.bottom, 40)
                .frame(width: 393, alignment: .trailing)
                .background(Color.backGround.opacity(0.5).blur(radius: 25))
            }
            
        }//.padding()
        
    }
}

//#Preview {
//    SubRuleModalView()
//        .modelContainer(for: Item.self, inMemory: true)
//}
