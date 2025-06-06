import SwiftData
import SwiftUI

struct SubRuleModalView: View {
    @Environment(\.modelContext) var context

    @Query var bookmarks: [Bookmark]

    @State private var showToast = false
    @State private var isBookmarked = false

    var content: Content
    /* var allContents: [Content]  // 전체 콘텐츠 배열

    // 현재 인덱스 계산
    var currentIndex: Int? {
        allContents.firstIndex(where: { $0.id == content.id })
    }

    var previousContent: Content? {
        guard let index = currentIndex, index > 0 else { return nil }
        return allContents[index - 1]
    }

    var nextContent: Content? {
        guard let index = currentIndex, index < allContents.count - 1 else { return nil }
        return allContents[index + 1]
    } */

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
                                    if let bookmark = bookmarks.first(where: {
                                        $0.content?.id == content.id
                                    }) {
                                        context.delete(bookmark)
                                        try? context.save()
                                    }
                                    showToast = true
                                    DispatchQueue.main.asyncAfter(
                                        deadline: .now() + 2
                                    ) {
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
                                if let imageData = content.images?[index],
                                    let uiImage = UIImage(data: imageData)
                                {
                                    Spacer()
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 200)
                                        .clipped()
                                    Spacer()
                                } else {
                                    Spacer()
                                    Color.gray
                                        .frame(height: 200)
                                    Spacer()
                                }
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
                isBookmarked = bookmarks.contains {
                    $0.content?.id == content.id
                }
            }
            .onChange(of: bookmarks) { newValue in
                isBookmarked = newValue.contains {
                    $0.content?.id == content.id
                }
            }

            // 하단 페이지이동버튼 주석
            //            .safeAreaInset(edge: .bottom) {
            //
            //                HStack {
            //                    NavigationLink(destination: SubRuleModalView(content: content)) {
            //                        HStack {
            //                            Image("caret.left").tint(.white)
            //                            Text("이전페이지").font(.lgRegular)
            //                        }
            //                    }
            //                    Spacer()
            //                    NavigationLink(destination: SubRuleModalView(content: content)) {
            //                        HStack {
            //                            Text("다음페이지").font(.lgRegular)
            //                            Image("caret.left").rotationEffect(.degrees(180)).tint(.white)
            //                        }
            //                    }
            //                }
            //                .padding(.horizontal, 10)
            //                .padding(.top, 10)
            //                .padding(.bottom, 40)
            //                .frame(width: 393, alignment: .trailing)
            //                .background(Color.backGround.opacity(0.5).blur(radius: 25))
            //
            //                /* if previousContent != nil || nextContent != nil {
            //                    HStack {
            //                        if let previous = previousContent {
            //                            NavigationLink(destination: SubRuleModalView(content: previous, allContents: allContents)) {
            //                                HStack {
            //                                    Image("caret.left").tint(.white)
            //                                    Text(previous.name).font(.lgRegular)
            //                                }
            //                            }
            //                        }
            //                        Spacer()
            //                        if let next = nextContent {
            //                            NavigationLink(destination: SubRuleModalView(content: next, allContents: allContents)) {
            //                                HStack {
            //                                    Text(next.name).font(.lgRegular)
            //                                    Image("caret.left").rotationEffect(.degrees(180)).tint(.white)
            //                                }
            //                            }
            //                        }
            //                    }
            //                    .padding(.horizontal, 10)
            //                    .padding(.top, 10)
            //                    .padding(.bottom, 40)
            //                    .frame(width: 393, alignment: .trailing)
            //                    .background(Color.backGround.opacity(0.5).blur(radius: 25))
            //                } */
            //
            //            }

        }
    }
}
