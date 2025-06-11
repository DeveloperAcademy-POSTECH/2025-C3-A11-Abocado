//
//  FilterView.swift
//  rulebox
//
//  Created by POS on 6/9/25.
//
// TODO: Filter 선택된 내용 main rule book으로 넘길 수 있게 해야해

import SwiftData
import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) private var dismiss

    var game: GameName
    @ObservedObject var vm: MainRuleBookVM  // 필터상태 유지를 위한 vm 받아오기

    @Query var allContents: [Content]
    @Query var filterTags: [FilterTag]

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
        VStack(alignment: .leading, spacing: 50) {
            VStack(alignment: .leading, spacing: 14) {
                Text("보드게임의 버전과\n인원수를 선택해주세요")
                    .font(
                        Font.custom("Wanted Sans", size: 24)
                            .weight(.semibold)
                    )
                    .foregroundColor(Color.grayNeutral99)

                Text("인원수와 버전에 맞게 설명해드릴게요")
                    .font(Font.custom("SF Pro", size: 17))
                    .foregroundColor(Color.grayNeutral80)
            }
            .padding(.top, 30)
            .frame(width: 257, alignment: .topLeading)

            PreFilterSection(filterTags: gameFilterTags, vm: vm)

            Spacer()

            NavigationLink(destination: MainRuleBook(game: game, vm: vm)) {

                Text("선택 완료")
                    .font(Font.custom("Wanted Sans", size: 17))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(12)
                    .frame(
                        maxWidth: .infinity,
                        minHeight: 60,
                        alignment: .center
                    )
                    .background(Color.primaryNormal)
                    .cornerRadius(12)
            }
            Spacer()
        }
        .padding(.horizontal, 24)
        .navigationBarBackButtonHidden()
        .navigationTitle(game.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    backButtonToolbarIcon
                }
                .padding(.top, 17)
            }
        }
        .onAppear {
            vm.setupDefaults(from: gameFilterTags)
        }
    }
}
