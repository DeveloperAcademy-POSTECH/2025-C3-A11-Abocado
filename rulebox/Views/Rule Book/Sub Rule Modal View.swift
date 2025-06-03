//
//  Sub Rule Page.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//

import SwiftUI
import SwiftData

// 모달 페이지입니다.
struct SubRuleModalView: View {
    @State private var showToast = false
    
    @Environment(\.modelContext) var context
    //모든 북마크 불러오기
    @Query var bookmarks: [Bookmark]
    //현재 content가 북마크 되었는지 확인
    var content: Content
    var isBookmarked: Bool {
        bookmarks.contains {$0.content?.id == content.id}
    }
    
    var loremIpsum: String {
        if let url = Bundle.main.url(forResource: "lorem", withExtension: "txt", subdirectory: "Data"),
           let contents = try? String(contentsOf: url) {
            return contents
        }
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 60) {
                Button(action: {}) {
                    Text("이미지가 들어갈 거에요")
                }
                HStack {
                    Text("상세설명 제목").font(.title).bold()
                    Spacer()
                    Button(action: {
                        //북마크 제거
                        if let onBookmark = bookmarks.first(where: {$0.content?.id == content.id}) {
                            context.delete(onBookmark)
                        }
                        
                        showToast = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showToast = false
                        }
                    }) {
                        Image(systemName: "bookmark")
                    }
                }
                Text(loremIpsum)
                HStack {
                    NavigationLink(destination: SearchView()) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("이전 페이지")
                        }
                    }
                    Spacer()
                    NavigationLink(destination: SearchView()) {
                        HStack {
                            Text("다음 페이지")
                            Image(systemName: "chevron.right")
                        }
                    }
                }

            }.overlay(
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
        }.padding()

    }
}

//#Preview {
//    SubRuleModalView()
//        .modelContainer(for: Item.self, inMemory: true)
//}
