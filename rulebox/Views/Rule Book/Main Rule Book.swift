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
                    VStack {
                        ToolbarView(
                            title: game.name,
                            genres: game.genres,
                            isExapnded: $toolbarExteneded
                        )
                        .background(
                            Color.clear
                                .background(.ultraThinMaterial)
                                .ignoresSafeArea()
                                .opacity(toolbarExteneded ? 0 : 1)
                        )

                        .animation(.easeInOut, value: toolbarExteneded)
                        VStack(alignment: .leading, spacing: 20) {
                            //                    ZStack(alignment: .top) {
                            //                        GeometryReader { geo in
                            //                            let offset = geo.frame(in: .global).minY
                            //                            Image(systemName: "plus")
                            //                                .resizable()
                            //                                .scaledToFit()
                            //                                .frame(height: 276)
                            //                                .blur(radius: offset < 0 ? min(10, abs(offset) / 10) : 0)
                            //                                .opacity(offset < -200 ? 0 : 1)
                            //                                .offset(y: offset < 0 ? offset : 0)
                            //                        }
                            //                        .frame(height: 276)
                            //                    }

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

                                    VStack(alignment: .leading, spacing: 8) {
                                        Button(action: {
                                            withAnimation {
                                                isExpandedMap[cat.id] =
                                                    !expanded
                                            }
                                        }) {
                                            HStack {
                                                Text(cat.name)
                                                    .font(.smHeading)
                                                    .padding(.vertical, 8)
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
                                        }

                                        if expanded {
                                            ForEach(filtered, id: \.id) {
                                                content in
                                                NavigationLink(
                                                    destination:
                                                        contentDetailView(
                                                            content
                                                        )
                                                ) {
                                                    HStack {
                                                        Text(content.name).font(
                                                            .lgRegular
                                                        )
                                                        Spacer()
                                                    }
                                                }
                                                .padding(.vertical, 4)
                                            }
                                        }
                                    }.padding(.vertical, 20).padding(
                                        .horizontal,
                                        14
                                    )
                                    .background(
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

                                    VStack(alignment: .leading, spacing: 8) {
                                        Button(action: {
                                            withAnimation {
                                                isExpandedMap[cat.id] =
                                                    !expanded
                                            }
                                        }) {
                                            HStack {
                                                Text(cat.name)
                                                    .font(.smHeading)
                                                    .padding(.vertical, 8)
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
                                        }

                                        if expanded {
                                            ForEach(filtered, id: \.id) {
                                                content in
                                                NavigationLink(
                                                    destination:
                                                        contentDetailView(
                                                            content
                                                        )
                                                ) {
                                                    HStack {
                                                        Text(content.name).font(
                                                            .lgRegular
                                                        )
                                                        Spacer()
                                                    }
                                                }
                                                .padding(.vertical, 4)
                                            }
                                        }
                                    }.padding(.vertical, 20).padding(
                                        .horizontal,
                                        14
                                    )
                                    .background(
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

                                    VStack(alignment: .leading, spacing: 8) {
                                        Button(action: {
                                            withAnimation {
                                                isExpandedMap[cat.id] =
                                                    !expanded
                                            }
                                        }) {
                                            HStack {
                                                Text(cat.name)
                                                    .font(.smHeading)
                                                    .padding(.vertical, 8)
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
                                        }

                                        if expanded {
                                            ForEach(filtered, id: \.id) {
                                                content in
                                                NavigationLink(
                                                    destination:
                                                        contentDetailView(
                                                            content
                                                        )
                                                ) {
                                                    HStack {
                                                        Text(content.name).font(
                                                            .lgRegular
                                                        )
                                                        Spacer()
                                                    }
                                                }
                                                .padding(.vertical, 4)
                                            }
                                        }
                                    }.padding(.vertical, 20).padding(
                                        .horizontal,
                                        14
                                    )
                                    .background(
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
                        .padding()
                        .background(
                            GeometryReader { geo in
                                Color.clear
                                    .preference(
                                        key: ScrollOffsetPreferenceKey.self,
                                        value: geo.frame(in: .global).minY
                                    )
                            }
                        )
                    }
                }.overlay(alignment: .top) {
                    if !toolbarExteneded {
                        ToolbarView(
                            title: game.name,
                            genres: game.genres,
                            isExapnded: .constant(false)
                        )
                        .background(.ultraThinMaterial)
                    }
                }
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { offset in
                    withAnimation {
                        if offset < outerGeo.safeAreaInsets.top - 312 {
                            toolbarExteneded = false
                        } else {
                            toolbarExteneded = true
                        }
                    }
                }
                //            .navigationTitle(game.name)
                .navigationBarTitleDisplayMode(.inline)
                //            .toolbar {
                //                MainRuleBookToolbar(dismiss: dismiss)
                //            }
                .navigationBarBackButtonHidden()
                .onAppear {
                    // set default filter value
                    vm.setupDefaults(from: gameFilterTags)
                }
            }
            //            .navigationTitle(game.name)
            .navigationBarTitleDisplayMode(.inline)
            //            .toolbar {
            //                MainRuleBookToolbar(dismiss: dismiss)
            //            }
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
                homeToolbarIcon
            }
        }
        ToolbarItem(placement: .topBarTrailing) {
            NavigationLink(destination: SearchView()) {
                searchToolbarIcon
            }
        }
        ToolbarItem(placement: .topBarTrailing) {
            NavigationLink(destination: BookmarkView()) {
                bookmarkToolbarIcon
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

private struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
