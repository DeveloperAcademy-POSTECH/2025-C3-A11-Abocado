//
//  MainRuleBook.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//

import SwiftUI
import SwiftData

struct MainRuleBook: View {
    var game: GameName
    
    @Query var majorCats: [MajorCat]
    @Query var contents: [Content]
    @Query var filterTags: [FilterTag]

    @StateObject private var vm = MainRuleBookVM()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        let partyValues = vm.partyValues(from: filterTags)
                        let extensionValues = vm.extensionValues(from: filterTags)

                        DisclosureGroup("인원수 필터") {
                            ForEach(partyValues, id: \.self) { value in
                                Button(action: { vm.selectedParty = value }) {
                                    HStack {
                                        Text(value)
                                        if vm.selectedParty == value {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        }

                        DisclosureGroup("확장판 필터") {
                            ForEach(extensionValues, id: \.self) { value in
                                Button(action: { vm.selectedExtension = value }) {
                                    HStack {
                                        Text(value)
                                        if vm.selectedExtension == value {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        }
                    }

                    ForEach(majorCats) { cat in
                        DisclosureGroup {
                            contentList(for: cat)
                        } label: {
                            Text(cat.name)
                                .font(.headline)
                                .padding(.vertical, 8)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle(game.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "house")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: SearchView()) {
                        Image(systemName: "magnifyingglass")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: BookmarkView()) {
                        Image(systemName: "bookmark")
                    }
                }
            }
            .navigationBarBackButtonHidden()
        }
    }

    // MARK: - Subviews

    private func contentList(for cat: MajorCat) -> some View {
        let filtered = vm.filteredContents(for: cat, from: contents)
        return ForEach(filtered, id: \.id) { content in
            NavigationLink(destination: contentDetailView(content)) {
                Text(content.name)
            }
            .padding(.vertical, 4)
        }
    }

    private func contentDetailView(_ content: Content) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(content.texts, id: \.self) { text in
                    Text(text)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
        }
        .navigationTitle(content.name)
    }
}

