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

    @Query var allContents: [Content]
    @Query var filterTags: [FilterTag]

    @StateObject private var vm = MainRuleBookVM()
    @Environment(\.dismiss) private var dismiss

    // get tags for selected game
    var gameFilterTags: [FilterTag] {
        let contents = allContents.filter { $0.gameName.name == game.name }
        let allTags = contents.compactMap { $0.filterTable?.filtertags ?? [] }
        let merged = allTags.flatMap { $0 }
        var uniqueTags = [FilterTag]()
        var seenIds = Set<UUID>()
        for tag in merged {
            if !seenIds.contains(tag.id) {
                uniqueTags.append(tag)
                seenIds.insert(tag.id)
            }
        }
        return uniqueTags
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // 여기에 이미지가 들어가고
                    
                    
                    // view body
                    // 까만블록으로 감싸야할텐데 나중에 누가 해주겠지 0.0
                    FilterSection(filterTags: gameFilterTags, vm: vm)

                    ForEach(filteredMajorCats, id: \.id) { cat in
                        let filtered = vm.filteredContents(for: cat, from: filteredContents)
                        if !filtered.isEmpty {
                            DisclosureGroup {
                                ForEach(filtered, id: \.id) { content in
                                    NavigationLink(destination: contentDetailView(content)) {
                                        Text(content.name)
                                    }
                                    .padding(.vertical, 4)
                                }
                            } label: {
                                Text(cat.name)
                                    .font(.headline)
                                    .padding(.vertical, 8)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle(game.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {

                MainRuleBookToolbar(dismiss: dismiss)
            }
            .navigationBarBackButtonHidden()
            .onAppear {
                // set default filter value
                vm.setupDefaults(from: gameFilterTags)
            }
        }
    }


    // get contents belong to current game
    var filteredContents: [Content] {
        allContents.filter { $0.gameName.name == game.name }
    }

    // get MajorCats that have content matching content for filter
    var filteredMajorCats: [MajorCat] {
        let grouped = Dictionary(grouping: filteredContents, by: { $0.majorCat })
        return grouped
            .filter { !vm.filteredContents(for: $0.key, from: $0.value).isEmpty }
            .map { $0.key }
            .sorted { $0.name < $1.name }
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

struct MainRuleBookToolbar: ToolbarContent {
    var dismiss: DismissAction

    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: { dismiss() }) {
                Image(systemName: "house") // icon 수정해주세요
            }
        }
        ToolbarItem(placement: .topBarTrailing) {
            NavigationLink(destination: SearchView()) {
                Image(systemName: "magnifyingglass") // icon 수정해주세요
            }
        }
        ToolbarItem(placement: .topBarTrailing) {
            NavigationLink(destination: BookmarkView()) {
                Image(systemName: "bookmark") // icon 수정해주세요
            }
        }
    }
}

struct FilterSection: View {
    var filterTags: [FilterTag]
    @ObservedObject var vm: MainRuleBookVM

    var body: some View {
        HStack {
            // 나중에 하프모달로 뜨게 수정해야돼 엉엉
            let partyValues = vm.partyValues(from: filterTags)
            let extensionValues = vm.extensionValues(from: filterTags)

            DisclosureGroup("확장판 필터: \(vm.selectedExtensions.count)개") {
                ForEach(extensionValues, id: \.self) { value in
                    Button(action: { vm.toggleExtension(value) }) {
                        HStack {
                            Text(value)
                            if vm.selectedExtensions.contains(value) {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
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
        }
    }
}
