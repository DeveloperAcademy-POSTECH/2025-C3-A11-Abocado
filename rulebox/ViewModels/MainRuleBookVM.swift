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
    @Published var selectedExtensions: Set<String> = []
    @Published var selectedContetnt: Content? = nil
    @Published var onSubRuleBook: Bool = false

    // init selected value setting
    func setupDefaults(from tags: [FilterTag]) {
        if selectedParty == nil {
            let party = partyValues(from: tags).first
            selectedParty = party
        }
        if selectedExtensions.isEmpty {
            selectedExtensions = ["basic"]
        }
    }
    
    
    func partyValues(from filterTags: [FilterTag]) -> [String] {
        Set(filterTags.filter { $0.type == "party" }.map { $0.value }).sorted()
    }
    func extensionValues(from filterTags: [FilterTag]) -> [String] {
        Set(filterTags.filter { $0.type == "extension" }.map { $0.value }).sorted()
    }

    func toggleExtension(_ ext: String) {
        if selectedExtensions.contains(ext) {
            selectedExtensions.remove(ext)
        } else {
            selectedExtensions.insert(ext)
        }
    }

    func filteredContents(for cat: MajorCat, from contents: [Content]) -> [Content] {
        contents.filter { content in
            content.majorCat.id == cat.id &&
            (selectedParty == nil || contentHasFilter(content, type: "party", value: selectedParty!)) &&
            (selectedExtensions.isEmpty || contentHasAnyExtension(content))
        }.sorted { $0.name < $1.name }
    }
    
    /// 대분류가 필요없는 경우바로 상세보기를 띄운다
    func ifNoMajCat (
        cat: MajorCat,
        from contents: [Content]
    ){
        let filtered = filteredContents(for: cat, from: contents)
        
        if let check = filtered.first(where: { $0.name == cat.name }) {
            selectedContetnt = check
            onSubRuleBook = true
        } else {
            onSubRuleBook = false
        }
    }

    private func contentHasFilter(_ content: Content, type: String, value: String) -> Bool {
        content.filterTable?.filtertags.contains { $0.type == type && $0.value == value } ?? false
    }

    private func contentHasAnyExtension(_ content: Content) -> Bool {
        guard let table = content.filterTable else { return false }
        for tag in table.filtertags where tag.type == "extension" {
            if selectedExtensions.contains(tag.value) {
                return true
            }
        }
        return false
    }
}
