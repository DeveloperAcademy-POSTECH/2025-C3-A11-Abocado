import SwiftData
import SwiftUI
import Lottie

struct SubRuleModalView: View {
    @Environment(\.modelContext) var context

    @Query var bookmarks: [Bookmark]
    @Query var contents: [Content]

    @State private var showToast = false
    @State private var isBookmarked = false
    @State private var bookmarkStates: [UUID: Bool] = [:]

    var content: Content

    var body: some View {
        NavigationStack {
            ContentToolbarView(content: content)
            ScrollView {
                    VStack(alignment: .leading) {
                        
//                            Text(content.majorCat.name)
//                                .font(.lgRegular)
//                                .foregroundColor(.grayNeutral70)
//                                .multilineTextAlignment(.leading)
                        
                        // 한 majorCat 페이지에 모든 content 불러오는건 성공
                        ForEach(contents.filter{$0.majorCat.id == content.majorCat.id}) {content in
                            HStack {
                                Text(content.name)
                                    .font(.mdHeading)
                                    .foregroundColor(.white)
                                Spacer()

                                // 북마크 버튼x
                                Button(action: {
                                    if let current = bookmarkStates[content.id], current {
                                            // 북마크 제거
                                            if let bookmark = bookmarks.first(where: { $0.content?.id == content.id }) {
                                                context.delete(bookmark)
                                                try? context.save()
                                            }
                                            bookmarkStates[content.id] = false
                                            showToast = true
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                showToast = false
                                            }
                                        } else {
                                            // 북마크 추가
                                            let newBookmark = Bookmark(content: content)
                                            context.insert(newBookmark)
                                            try? context.save()
                                            bookmarkStates[content.id] = true
                                        }
                                }) {
                                    let isBookmarked = bookmarkStates[content.id] ?? false
                                        (isBookmarked ? AnyView(bookmarkFilledIcon) : AnyView(bookmarkIcon))
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
//            .onAppear {
//                isBookmarked = bookmarks.contains {
//                    $0.content?.id == content.id
//                }
//            }
            .onAppear {
                for content in contents.filter({ $0.majorCat.id == self.content.majorCat.id }) {
                    let isBookmarked = bookmarks.contains { $0.content?.id == content.id }
                    bookmarkStates[content.id] = isBookmarked
                }
            }

            .onChange(of: bookmarks) { newValue in
                isBookmarked = newValue.contains {
                    $0.content?.id == content.id
                }
            }

        }
        .navigationBarHidden(true)
//        .safeAreaInset(edge: .top) {
//            ContentToolbarView(content: content)
//        }
    }
}
