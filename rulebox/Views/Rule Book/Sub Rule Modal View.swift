import SwiftData
import SwiftUI
import Lottie

struct SubRuleModalView: View {
    @Environment(\.modelContext) var context

    @Query var bookmarks: [Bookmark]
    @Query var contents: [Content]

    @State private var showToast = false
    @State private var isBookmarked = false
    //@State private var bookmarkStates: [UUID: Bool] = [:]

    var content: Content

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    

                        Text(content.majorCat.name)
                            .font(.lgRegular)
                            .foregroundColor(.grayNeutral70)
                            .multilineTextAlignment(.leading)
                    
                    // 한 majorCat 페이지에 모든 content 불러오는건 성공
                    ForEach(contents.filter{$0.majorCat.id == content.majorCat.id}) {currentContent in
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
                    
//                        ForEach(0..<content.texts.count, id: \.self) { index in
//                            ForEach(0..<content.images.count, id: \.self) { index in
//                                LottieView(content.images[index])
//                                    .frame(width: 353, height: 275)
//                                Text(content.texts[index])
//                                    .foregroundColor(.grayNeutral99)
//                                    .font(.lgRegular)
//                                    .padding(.bottom, 34)
//                            }
//                        }
                    
                    ForEach(0..<content.texts.count, id: \.self) { index in
                        let parts = content.texts[index].split(separator: "*", maxSplits: 2, omittingEmptySubsequences: false)
                        let separated = content.texts[index].components(separatedBy: "***")
                        let imageFileName = separated.first ?? ""
                        let textContent = separated.count > 1 ? separated[1] : content.texts[index]
                        
                        VStack(alignment: .leading) {
                            if !imageFileName.isEmpty {
                                LottieView(filename: imageFileName)
                                    .frame(width: 353, height: 275)
                                    .clipped()
                                        .fixedSize()
                            }
                            Text(content.texts[index])
                                .foregroundColor(.grayNeutral99)
                                .font(.lgRegular)
                                .padding(.bottom, 34)
                        }
                    }
                    
//                    ForEach(0..<content.texts.count, id: \.self) { index in
//                        LottieView(filename: content.images[index])
//                        Text(content.texts[index])
//                            .foregroundColor(.grayNeutral99)
//                            .font(.lgRegular)
//                            .padding(.bottom, 34)
//                    }
                        
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
