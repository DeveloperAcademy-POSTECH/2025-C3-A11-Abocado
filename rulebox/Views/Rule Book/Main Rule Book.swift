//
//  Main Rule Book.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//

import SwiftUI

struct MainRuleBook: View {
    @State private var isExpanded = false
    var body: some View {
        NavigationStack {

            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        Text("기본판")
                            .font(.title)
                        Spacer()
                        Text("2명")
                            .font(.title)
                    }

                    DisclosureGroup(isExpanded: $isExpanded) {
                        VStack(alignment: .leading, spacing: 10) {
                            NavigationLink(destination: SearchView()) {
                                HStack {
                                    Text("게임 준비")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }.frame(height: 25).padding()
                            }
                            NavigationLink(destination: SearchView()) {
                                HStack {
                                    Text("타일 놓기")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }.frame(height: 25).padding()
                            }
                            NavigationLink(destination: SearchView()) {
                                HStack {
                                    Text("점수 계산")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }.frame(height: 25).padding()
                            }
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(height: 92)
                                .foregroundColor(.clear)
                            HStack {
                                Text("게임 진행")
                                Spacer()
                            }
                            .padding()
                        }
                    }
                    Button(action: {}) {
                        RoundedRectangle(cornerRadius: 16).frame(height: 92)
                    }
                    Button(action: {}) {
                        RoundedRectangle(cornerRadius: 16).frame(height: 92)
                    }
                    Button(action: {}) {
                        RoundedRectangle(cornerRadius: 16).frame(height: 92)
                    }
                    Button(action: {}) {
                        RoundedRectangle(cornerRadius: 16).frame(height: 92)
                    }
                    Button(action: {}) {
                        RoundedRectangle(cornerRadius: 16).frame(height: 92)
                    }
                    Button(action: {}) {
                        RoundedRectangle(cornerRadius: 16).frame(height: 92)
                    }
                    Button(action: {}) {
                        RoundedRectangle(cornerRadius: 16).frame(height: 92)
                    }
                }
            }
            .padding().toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink(
                        destination: GameSelectView()
                    ) {
                        Image(systemName: "house")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(
                        destination: SearchView()
                    ) {
                        Image(systemName: "magnifyingglass")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(
                        destination: BookmarkView()
                    ) {
                        Image(systemName: "bookmark")
                    }
                }
            }
            .navigationTitle("카르카손").navigationBarTitleDisplayMode(.inline)
        }.navigationBarBackButtonHidden(true)

    }
}

#Preview {
    MainRuleBook()
        .modelContainer(for: Item.self, inMemory: true)
}
