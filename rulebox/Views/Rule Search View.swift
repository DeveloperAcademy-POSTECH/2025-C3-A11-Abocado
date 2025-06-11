//
//  Search View.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//

import SwiftData
import SwiftUI

struct SearchView: View {

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query private var rules: [SearchRules]

    @Query var allContents: [Content]
    @State var searchedContent: [Content] = []
    @State private var searchText: String = ""
    
    //SubRuleModalView() modal sheet
    @State private var onSubRuleModalView = false
    @State private var selectedContent: Content? = nil

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    // 검색 바
                    HStack {
                        Image("search")  //대소문자 구분해야됨 -사나
                            .renderingMode(.template)
                            .foregroundColor(.white)

                        TextField("검색어를 입력하세요", text: $searchText)
                            .onSubmit {
                                
                                let keyword = searchText
                                    .lowercased()
                                    .trimmingCharacters(in: .whitespacesAndNewlines)
                                
                                guard !keyword.isEmpty else { return }

                                // 중복 여부 검사
                                let isAlreadySaved = rules.contains { $0.name.lowercased() == keyword }

                                if !isAlreadySaved {
                                    let newSearch = SearchRules(name: keyword)
                                    modelContext.insert(newSearch)
                                }

                                print(keyword)
                                print("전체 콘텐츠: \(allContents.map(\.words))")

                                // 검색된 콘텐츠 필터링
                                searchedContent = allContents.filter {
                                    ($0.words?.contains {
                                        $0.lowercased().contains(keyword)
                                        || $0.lowercased().hasPrefix(keyword)
                                    }) ?? false
                                }

                                print("검색된 콘텐츠: \(searchedContent.map(\.name))")
                            }

                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                            }) {
                                Image("cancel")
                                    .renderingMode(.template)
                                    .foregroundColor(.grayNeutral80)
                            }
                        }
                    }
                    .padding(8)
                    .background(Color(.systemGray6))
                    .clipShape(.capsule)

                    // 최근 검색어
                    VStack(spacing: 16) {
                        HStack {
                            Text("최근 검색어").font(.lgSemiBold)
                            Spacer()
                            Text("전체 삭제").font(.mdRegular)
                                .foregroundColor(.grayNeutral70).onTapGesture {
                                    for rule in rules {
                                        modelContext.delete(rule)
                                    }
                                }
                        }.padding(.horizontal, 0)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(
                                    rules.sorted(by: { $0.date > $1.date }),
                                    id: \.self
                                ) { rule in
                                    SearchedCapsule(title: rule.name, onTap: {})
                                    {
                                        modelContext.delete(rule)
                                    }
                                }
                            }
                        }.frame(height: 40)
                    }.padding(.vertical, 14)

                    if !searchText.isEmpty {

                        VStack(alignment: .leading, spacing: 8) {
                            Text("검색된 룰").font(.lgSemiBold)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(searchedContent, id: \.self) { content in
                                        Button(action: {
                                            selectedContent = content
                                        }) {
                                            Text(content.name)
                                                .padding(.horizontal, 12)
                                                .padding(.vertical, 8)
                                                .background(Color.grayNeutral30)
                                                .cornerRadius(8)
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                            }.frame(height: 40)
                        }.padding(.top)
                    }

                    // 자주 찾는 페이지
                    Text(
                        "자주 찾는 페이지"
                    ).font(.lgSemiBold).padding(.horizontal, 0).padding(
                        .vertical,
                        14
                    )

                    VStack(spacing: 10) {
                        MostVisitedPage(
                            number: 1,
                            title: "도로 점수 계산하기",
                            subtitle: "게임 진행 - 도로",
                            onTap: {}
                        )
                        MostVisitedPage(
                            number: 2,
                            title: "성 점수 계산하기",
                            subtitle: "게임 진행 - 성",
                            onTap: {}
                        )
                        MostVisitedPage(
                            number: 3,
                            title: "도로 점수 계산하기",
                            subtitle: "게임 진행 - 도로",
                            onTap: {}
                        )
                        MostVisitedPage(
                            number: 4,
                            title: "도로 점수 계산하기",
                            subtitle: "게임 진행 - 도로",
                            onTap: {}
                        )
                        MostVisitedPage(
                            number: 5,
                            title: "도로 점수 계산하기",
                            subtitle: "게임 진행 - 도로",
                            onTap: {}
                        )
                    }

                    Spacer()
                }
                .padding()
            }
            .sheet(item: $selectedContent) { content in
                /// 대분류가 없는 경우, 다이렉트로 content표시
                SubRuleModalView(content: content)
            }

            .ignoresSafeArea(.keyboard)
        }
        .navigationTitle("설명서 검색")
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    backButtonToolbarIcon
                }
            }
        }
        .background(Color.backGround)

    }
}

#Preview {
    SearchView()
        .modelContainer(for: Item.self, inMemory: true)
}

struct MostVisitedPage: View {
    let number: Int
    let title: String
    let subtitle: String
    let onTap: () -> Void
    var body: some View {
        HStack(spacing: 16) {
            Text(number.formatted()).font(.lgRegular).foregroundColor(
                .primaryNormal
            )
            VStack(alignment: .leading) {
                Text(subtitle)
                    .font(.mdRegular)
                    .foregroundColor(.gray)  //TODO: 칼라 변경 필요
                Text(title)
                    .font(.lgMedium)
            }
            Spacer()
        }
        .contentShape(Rectangle())  // To make entire row tappable
        .onTapGesture {
            onTap()
        }
    }
}
