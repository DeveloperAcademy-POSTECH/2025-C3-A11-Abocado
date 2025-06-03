//
//  Search View.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//

import SwiftUI

struct SearchView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                // 검색 바
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)

                    TextField("검색어를 입력하세요", text: $searchText)
                        .onSubmit {
                            // 검색하기
                        }

                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(8)
                .background(Color(.systemGray6))
                .clipShape(.capsule)

                // 최근 검색어
                HStack {
                    Text("최근 검색어").font(.lgSemiBold)
                    Spacer()
                    Text("전체 삭제").font(.mdRegular)  //TODO: 칼라 변경 필요
                }.padding()

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        SearchedCapsule(title: "타일")
                        SearchedCapsule(title: "성")
                        SearchedCapsule(title: "제목")
                        SearchedCapsule(title: "타일")
                    }
                }.frame(height: 40)

                // 자주 찾는 페이지
                Text(
                    "자주 찾는 페이지"
                ).font(.lgSemiBold).padding()

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

                Spacer()
            }.padding()
        }.navigationTitle("설명서 검색")
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                    }
                }
            }

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
        HStack {
            Text(number.formatted()).font(.lgRegular).padding()
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
