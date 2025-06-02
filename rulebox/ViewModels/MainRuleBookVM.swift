//
//  MainRuleBookVM.swift
//  rulebox
//
//  Created by POS on 6/2/25.
//

import Foundation
import SwiftData

@MainActor
class MainRuleBookVM: ObservableObject {
    @Published var selectedParty: String? = nil
    @Published var selectedExtension: String? = nil

    // only listing unique values
    func partyValues(from filterTags: [FilterTag]) -> [String] {
        Set(filterTags.filter { $0.type == "party" }.map { $0.value }).sorted()
    }
    func extensionValues(from filterTags: [FilterTag]) -> [String] {
        Set(filterTags.filter { $0.type == "extension" }.map { $0.value }).sorted()
    }

    // filtering process
    func filteredContents(for cat: MajorCat, from contents: [Content]) -> [Content] {
        contents.filter { content in
            content.majorCat.id == cat.id &&
            (selectedParty == nil || contentHasFilter(content, type: "party", value: selectedParty!)) &&
            (selectedExtension == nil || contentHasFilter(content, type: "extension", value: selectedExtension!))
        }
    }

    private func contentHasFilter(_ content: Content, type: String, value: String) -> Bool {
        if let table = content.filterTable {
            return table.filtertags.contains { $0.type == type && $0.value == value }
        }
        return false
    }
}
