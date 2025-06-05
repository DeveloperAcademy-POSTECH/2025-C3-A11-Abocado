//
//  Main Rule Filter.swift
//  rulebox
//
//  Created by POS on 6/5/25.
//

import Foundation
import SwiftUI

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
