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
                        //TODO: 타이틀 사이즈 변경 필요
//                        if showCompactHeader {
//                            LargeToolbarView(game: game)
//                        } else {
                        LargeToolbarView(game: game)
//                        }
                        VStack(alignment: .leading, spacing: 12) {
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
                            // view body
                            FilterSection(filterTags: gameFilterTags, vm: vm)
                                .padding(.horizontal, 18).padding(.top, 24)
                            
                            ForEach(filteredMajorCats, id: \.id) { cat in
                                let filtered = vm.filteredContents(for: cat, from: filteredContents)

                                MajCatButtonView(
                                    cat: cat,
                                    contents: filtered,
                                    isExpanded: Binding( //Binding value를 raw하게 넘기니까 compile불가하다고 뜸. 
                                                get: { isExpandedMap[cat.id, default: false] },
                                                set: { isExpandedMap[cat.id] = $0 }
                                            ),
                                    selectedContent: $selectedContent,
                                    onSubRuleModalView: $onSubRuleModalView
                                )
                                
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

// Custom shape for rounding specific corners
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
