import SwiftData
import SwiftUI

struct SubRuleModalView: View {
    @Environment(\.modelContext) var context

    @Query var bookmarks: [Bookmark]
    
    @State private var showToast = false
    @State private var isBookmarked = false

    var content: Content

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    VStack(alignment: .leading) {
                        Text(content.majorCat.name)
                            .font(.lgRegular)
                            .foregroundColor(.grayNeutral70)
                        
                        HStack {
                            Text(content.name)
                                .font(.mdHeading)
                                .foregroundColor(.white)
                            Spacer()
                            
                            // 북마크 버튼
                            Button(action: {
                                if isBookmarked {
                                    // 북마크 제거
                                    if let bookmark = bookmarks.first(where: { $0.content?.id == content.id }) {
                                        context.delete(bookmark)
                                        try? context.save()
                                    }
                                    showToast = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        showToast = false
                                    }
                                } else {
                                    // 북마크 추가
                                    let newBookmark = Bookmark(content: content)
                                    context.insert(newBookmark)
                                    try? context.save()
                                }

                                isBookmarked.toggle()
                            }) {
                                (isBookmarked
                                 ? AnyView(bookmarkFilledIcon)
                                 : AnyView(bookmarkIcon))
                                .frame(width: 40, height: 40)
                            }
                        }
                    }

                    ForEach(0..<content.texts.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            HStack {
                                Spacer()
                                Text("이미지가 들어갈 거에요")
                                Spacer()
                            }
                            .padding(.bottom, 12)

                            Text(content.texts[index])
                                .foregroundColor(.grayNeutral99)
                                .font(.lgRegular)
                                .padding(.bottom, 34)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 50)
                .overlay(
                    Group {
                        if showToast {
                            Text("북마크에서 제거되었습니다")
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
            .onAppear {
                isBookmarked = bookmarks.contains { $0.content?.id == content.id }
            }
            .onChange(of: bookmarks) { newValue in
                isBookmarked = newValue.contains { $0.content?.id == content.id }
            }
            .safeAreaInset(edge: .bottom) {
                HStack {
                    NavigationLink(destination: SearchView()) {
                        HStack {
                            Image("caret.left").tint(.white)
                            Text("이전 페이지").font(.lgRegular)
                        }
                    }
                    Spacer()
                    NavigationLink(destination: SearchView()) {
                        HStack {
                            Text("다음 페이지").font(.lgRegular)
                            Image("caret.left").rotationEffect(.degrees(180)).tint(.white)
                        }
                    }
                }
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .padding(.bottom, 40)
                .frame(width: 393, alignment: .trailing)
                .background(Color.backGround.opacity(0.5).blur(radius: 25))
            }
        }
    }
}
