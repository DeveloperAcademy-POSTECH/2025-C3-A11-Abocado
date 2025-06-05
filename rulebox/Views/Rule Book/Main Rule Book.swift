//
//  MainRuleBook.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//

import SwiftData
import SwiftUI
import UIKit

struct MainRuleBook: View {
    var game: GameName

    @Query var allContents: [Content]
    @Query var filterTags: [FilterTag]

    @StateObject private var vm = MainRuleBookVM()
    @Environment(\.dismiss) private var dismiss
    @State private var isExpandedMap: [UUID: Bool] = [:]

    @State private var showCompactHeader: Bool = false

    //SubRuleModalView() modal sheet
    @State private var selectedContent: Content? = nil
    @State private var onSubRuleModalView = false
    @State private var selectedContent: Content? = nil

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
            GeometryReader { outerGeo in
                ScrollView {
                    VStack(spacing: 0) {

                        Color.clear
                            .frame(height: 1)
                            .background(
                                GeometryReader { geo in
                                    Color.clear.preference(
                                        key: ScrollOffsetKey.self,
                                        value: geo.frame(in: .global).minY
                                    )
                                }
                            )
                        if showCompactHeader {
                            SmallToolbarView(game: game)
                        } else {
                            LargeToolbarView(game: game)
                        }
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

                                            if let direct = filtered.first(
                                                where: { $0.name == cat.name })
                                            {
                                                selectedContent = direct
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
                                                    : AnyView(plusIcon))

                                            }
                                            .padding(.vertical, 0)
                                            .padding(.horizontal, 16)
                                            .contentShape(Rectangle())
                                        }.buttonStyle(.plain)

                                        if expanded {
                                            ForEach(filtered, id: \.id) {
                                                content in
                                                Button(
                                                    action: {
                                                        selectedContent = content
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
                                                .sheet(item: $selectedContent) { content in
                                                    SubRuleModalView(content: content)
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
                    .onPreferenceChange(ScrollOffsetKey.self) { value in
                        showCompactHeader =
                            value < outerGeo.safeAreaInsets.top - 50
                        print("Scroll offset: \(value)")
                    }
                    .animation(
                        .easeInOut(duration: 0.25),
                        value: showCompactHeader
                    )
                    .onAppear {
                        vm.setupDefaults(from: gameFilterTags)
                    }
                }
                .onAppear {
                    vm.setupDefaults(from: gameFilterTags)
                }
            }
        }
        .navigationBarHidden(true)
        .sheet(item: $selectedContent) { content in
            /// 대분류가 없는 경우, 다이렉트로 content표시
            SubRuleModalView(content: content)
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
                .sorted { $0.name > $1.name }
        }
    }
}

// PreferenceKey for detecting scroll
struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
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

            DisclosureGroup("확장 추가: \(vm.selectedExtensions.count)개") {
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
            .background(
                Color.atomicOpacity20
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
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
            }.background(
                Color.atomicOpacity20
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
        }
    }
}
