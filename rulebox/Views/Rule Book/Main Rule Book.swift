//
//  MainRuleBook.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//

import SwiftData
import SwiftUI

struct MainRuleBook: View {
    var game: GameName

    @Query var allContents: [Content]
    @Query var filterTags: [FilterTag]

    @StateObject private var vm = MainRuleBookVM()
    @Environment(\.dismiss) private var dismiss
    @State private var isExpandedMap: [UUID: Bool] = [:]

    @State private var toolbarExteneded: Bool = true

    //SubRuleModalView() modal sheet
    @State private var onSubRuleModalView = false

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
                VStack {
                    //                    ToolbarView(
                    //                        game: game,
                    //                        isExapnded: $toolbarExteneded
                    //                    )
                    //                    .background(
                    //                        Color.clear
                    //                            .background(.ultraThinMaterial)
                    //                            .ignoresSafeArea()
                    //                            //                                .opacity(toolbarExteneded ? 0 : 1)
                    //                    )
                    //                    .animation(.easeInOut, value: toolbarExteneded)
                    VStack(alignment: .leading, spacing: 12) {

                        // view body
                        FilterSection(filterTags: gameFilterTags, vm: vm)

                        ForEach(filteredMajorCats, id: \.id) { cat in
                            let filtered = vm.filteredContents(
                                for: cat,
                                from: filteredContents
                            )
                            if !filtered.isEmpty {
                                let expanded = isExpandedMap[
                                    cat.id,
                                    default: false
                                ]

                                VStack(alignment: .leading, spacing: 0) {
                                    Button(action: {
                                        withAnimation {
                                            isExpandedMap[cat.id] =
                                                !expanded
                                        }
                                    }) {
                                        HStack(spacing: 8) {
                                            Text(cat.name)
                                                .font(.smHeading)
                                                .foregroundColor(
                                                    expanded
                                                        ? .primaryNormal
                                                        : .white
                                                )
                                            Spacer()
                                            (expanded
                                                ? AnyView(minusIcon)
                                                : AnyView(
                                                    plusIcon
                                                ))

                                        }
                                        .padding(.vertical, 0)
                                        .padding(.horizontal, 16)
                                        .contentShape(Rectangle())
                                    }.buttonStyle(.plain)

                                    if expanded {
                                        ForEach(filtered, id: \.id) { content in
                                            Button(
                                                action: {
                                                    onSubRuleModalView = true
                                                },
                                                label: {
                                                    HStack {
                                                        Text(content.name)
                                                        Spacer()
                                                    }
                                                }
                                            )
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 14)
                                            .sheet(
                                                isPresented: $onSubRuleModalView
                                            ) {
                                                SubRuleModalView(
                                                    content: content
                                                )
                                            }

                                        }
                                    }
                                }.background(
                                    Group {
                                        if expanded {
                                            RoundedRectangle(
                                                cornerRadius: 20
                                            )
                                            .stroke(
                                                Color.primaryNormal,
                                                lineWidth: 1
                                            )
                                        }
                                    }
                                )
                            }
                        }
                    }
                }
                .onAppear {
                    vm.setupDefaults(from: gameFilterTags)
                }
            }
            .onAppear {
                vm.setupDefaults(from: gameFilterTags)
            }

        }

        // get contents belong to current game
        var filteredContents: [Content] {
            allContents.filter { $0.gameName.name == game.name }
        }

        // get MajorCats that have content matching content for filter
        var filteredMajorCats: [MajorCat] {
            let grouped = Dictionary(
                grouping: filteredContents,
                by: { $0.majorCat }
            )
            return
                grouped
                .filter {
                    !vm.filteredContents(for: $0.key, from: $0.value).isEmpty
                }
                .map { $0.key }
                .sorted { $0.name < $1.name }
        }
    }

}

struct ContentDetailView: View {
    let content: Content

    var body: some View {
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
