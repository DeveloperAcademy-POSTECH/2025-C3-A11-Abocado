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
                        Button(action: {}) {
                            Text("타일").padding(.horizontal, 8)
                        }
                        Button(action: {}) {
                            Image(systemName: "multiply")  // TODO: 아이콘 변경해야함
                        }
                    }.padding()
                        .overlay(Capsule().stroke(.gray, lineWidth: 1))  //TODO: 색변경 필요
                }

                // 자주 찾는 페이지
                Text(
                    "자주 찾는 페이지"
                ).font(.lgSemiBold).padding()

                HStack {
                    Text("1").font(.lgRegular).padding()

                    VStack(alignment: .leading) {
                        Text("게임 진행 - 도로")
                            .font(.mdRegular)
                            .foregroundColor(.gray)  //TODO: 칼라 변경 필요
                        Text("도로 점수 계산하기")
                            .font(.lgMedium)
                    }
                    Spacer()
                    //                    Image(systemName: "chevron.right")
                    //                        .foregroundColor(.gray)
                }
                .contentShape(Rectangle())  // To make entire row tappable
                .onTapGesture {
                    // Handle tap
                }

                HStack {
                    Text("2").font(.lgRegular).padding()

                    VStack(alignment: .leading) {
                        Text("게임 진행 - 성")
                            .font(.mdRegular)
                            .foregroundColor(.gray)
                        Text("성 점수 계산하기")
                            .font(.lgMedium)
                    }
                    Spacer()
                    //                    Image(systemName: "chevron.right")
                    //                        .foregroundColor(.gray)
                }
                .contentShape(Rectangle())  // To make entire row tappable
                .onTapGesture {
                    // Handle tap
                }
                Spacer()
            }.padding()
        }.navigationTitle("설명서 검색")
            .navigationBarTitleDisplayMode(.inline)

    }
}

#Preview {
    SearchView()
        .modelContainer(for: Item.self, inMemory: true)
}
