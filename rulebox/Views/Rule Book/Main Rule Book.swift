//
//  MainRuleBook.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//
// TODO: 화면 양사이드에 불쾌한 패딩들어가있음 해결필요

import SwiftData
import SwiftUI
import UIKit

struct MainRuleBook: View {
    var game: GameName
    @ObservedObject var vm: MainRuleBookVM

    @Query var allContents: [Content]
    @Query var filterTags: [FilterTag]

    //@StateObject private var vm = MainRuleBookVM()
    @Environment(\.dismiss) private var dismiss
    @State private var isExpandedMap: [UUID: Bool] = [:]

    @State private var showCompactHeader: Bool = false

    //SubRuleModalView() modal sheet
    @State private var selectedContent: Content? = nil
    //    @State private var onSubRuleModalView = false

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
            ZStack {
                GeometryReader { outerGeo in
                    ScrollView {
                        ZStack {
                            //.ignoresSafeArea()는 ScrollView 안에서 적용이 안돼서 게임이미지 Toolbar에서 분리하고 여기 넣었습니다 - Nyx
                            //뒷배경 게임이미지
                            ImageConverter.imageConvert(game.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 393, height: 282, alignment: .top)
                                .clipped()
                            //게임이미지 그라디언트
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.black.opacity(0.0),  // 시작은 어둡게
                                    Color.black.opacity(0.7),  // 끝은 투명하게
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )

                            VStack(alignment: .leading) {
                                Spacer()
                                HStack(spacing: 5) {
                                    ForEach(
                                        game.genres,
                                        id: \.self
                                    ) { genre in
                                        GenreCapsule(
                                            title: genre, isSelected: true)
                                    }
                                    Spacer()
                                }
                                Text(game.name).font(.lgHeading)
                                    .padding(.bottom, 18)
                            }.padding(.horizontal, 20)
                        }//.ignoresSafeArea(edges: .horizontal)

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
                            VStack(alignment: .leading, spacing: 12) {

                                // view body
                                MainFilterSection(
                                    filterTags: gameFilterTags,
                                    vm: vm
                                )
                                .padding(.horizontal, 18).padding(.top, 24).padding(.bottom, 12)

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

                                        VStack(spacing: 0) {
                                            if let direct = filtered.first(
                                                where: { $0.name == cat.name })
                                                ?? filtered.first
                                            {
                                                NavigationLink(
                                                    destination:
                                                        SubRuleModalView(
                                                            content: direct)
                                                ) {
                                                    HStack(spacing: 8) {
                                                        Text(cat.name)
                                                            .font(.smHeading)
                                                            .foregroundColor(
                                                                .white)
                                                        Spacer()
                                                    }
                                                    .padding(.vertical, 10)
                                                    .padding(.bottom, 10)
                                                    .padding(.horizontal, 18)
                                                }
                                            }
                                            Divider()
                                                .ignoresSafeArea()
                                                .foregroundStyle(
                                                    Color.white.opacity(0.1)
                                                )
                                        }
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
                    }
                    .ignoresSafeArea()
                }
                LargeToolbarView(game: game)
            }.background(Color.backGround)
                .navigationBarHidden(true)

        }  // get contents belong to current game
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
                .sorted { $0.order < $1.order }
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
