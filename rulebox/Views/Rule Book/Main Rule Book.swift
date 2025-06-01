//
//  Main Rule Book.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//

import SwiftUI

//
//  Main Rule Book.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//

import SwiftUI
import SwiftData

struct MainRuleBook: View {
    @Query var majorCats: [MajorCat]
    @Query var contents: [Content]
    @Query var filterTags: [FilterTag]
    
    @State private var selectedParty: String? = nil
    @State private var selectedExtension: String? = nil
    @State private var expandedMajorCats: Set<UUID> = []
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack{
                        DisclosureGroup("인원수 필터") {
                            ForEach(filterTags.filter { $0.type == "party" }, id: \.id) { tag in
                                Button(action: {
                                    selectedParty = tag.value
                                }) {
                                    HStack {
                                        Text(tag.value)
                                        if selectedParty == tag.value {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        }
                        DisclosureGroup("확장판 필터") {
                            ForEach(filterTags.filter { $0.type == "extension" }, id: \.id) { tag in
                                Button(action: {
                                    selectedExtension = tag.value
                                }) {
                                    HStack {
                                        Text(tag.value)
                                        if selectedExtension == tag.value {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    // MajorCat List
                    ForEach(majorCats) { cat in
                        DisclosureGroup(isExpanded: Binding(
                            get: { expandedMajorCats.contains(cat.id) },
                            set: { expanded in
                                if expanded {
                                    expandedMajorCats.insert(cat.id)
                                } else {
                                    expandedMajorCats.remove(cat.id)
                                }
                            })
                        ) {
                            // filterd content List
                            let filteredContents = contents.filter { content in
                                content.majorCat.id == cat.id &&
                                (selectedParty == nil || contentHasFilter(content, type: "party", value: selectedParty!)) &&
                                (selectedExtension == nil || contentHasFilter(content, type: "extension", value: selectedExtension!))
                            }

                            ForEach(filteredContents, id: \.id) { content in
                                NavigationLink(destination: Text(content.text)) {
                                    Text(content.name)
                                }.padding(.vertical, 4)
                            }
                        } label: {
                            Text(cat.name)
                                .font(.headline)
                                .padding(.vertical, 8)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("카르카손")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "house")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: SearchView()) {
                        Image(systemName: "magnifyingglass")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: BookmarkView()) {
                        Image(systemName: "bookmark")
                    }
                }
            }
            .navigationBarBackButtonHidden() 
        }
    }

    // MARK: - Helper
    func contentHasFilter(_ content: Content, type: String, value: String) -> Bool {
        for table in content.filterTables {
            if table.filtertags.contains(where: { $0.type == type && $0.value == value }) {
                return true
            }
        }
        return false
    }

}

#Preview {
    MainRuleBook()
        .modelContainer(for: Item.self, inMemory: true)
}

//struct MainRuleBook: View {
//    @State private var isExpanded = false
//    var body: some View {
//        NavigationStack {
//
//            ScrollView {
//                VStack(spacing: 20) {
//                    HStack {
//                        Text("기본판")
//                            .font(.title)
//                        Spacer()
//                        Text("2명")
//                            .font(.title)
//                    }
//
//                    DisclosureGroup(isExpanded: $isExpanded) {
//                        VStack(alignment: .leading, spacing: 10) {
//                            NavigationLink(destination: SearchView()) {
//                                HStack {
//                                    Text("게임 준비")
//                                    Spacer()
//                                    Image(systemName: "chevron.right")
//                                }.frame(height: 25).padding()
//                            }
//                            NavigationLink(destination: SearchView()) {
//                                HStack {
//                                    Text("타일 놓기")
//                                    Spacer()
//                                    Image(systemName: "chevron.right")
//                                }.frame(height: 25).padding()
//                            }
//                            NavigationLink(destination: SearchView()) {
//                                HStack {
//                                    Text("점수 계산")
//                                    Spacer()
//                                    Image(systemName: "chevron.right")
//                                }.frame(height: 25).padding()
//                            }
//                        }
//                    } label: {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 16)
//                                .frame(height: 92)
//                                .foregroundColor(.clear)
//                            HStack {
//                                Text("게임 진행")
//                                Spacer()
//                            }
//                            .padding()
//                        }
//                    }
//                    Button(action: {}) {
//                        RoundedRectangle(cornerRadius: 16).frame(height: 92)
//                    }
//                    Button(action: {}) {
//                        RoundedRectangle(cornerRadius: 16).frame(height: 92)
//                    }
//                    Button(action: {}) {
//                        RoundedRectangle(cornerRadius: 16).frame(height: 92)
//                    }
//                    Button(action: {}) {
//                        RoundedRectangle(cornerRadius: 16).frame(height: 92)
//                    }
//                    Button(action: {}) {
//                        RoundedRectangle(cornerRadius: 16).frame(height: 92)
//                    }
//                    Button(action: {}) {
//                        RoundedRectangle(cornerRadius: 16).frame(height: 92)
//                    }
//                    Button(action: {}) {
//                        RoundedRectangle(cornerRadius: 16).frame(height: 92)
//                    }
//                }
//            }
//            .padding().toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    NavigationLink(
//                        destination: GameSelectView()
//                    ) {
//                        Image(systemName: "house")
//                    }
//                }
//                ToolbarItem(placement: .topBarTrailing) {
//                    NavigationLink(
//                        destination: SearchView()
//                    ) {
//                        Image(systemName: "magnifyingglass")
//                    }
//                }
//                ToolbarItem(placement: .topBarTrailing) {
//                    NavigationLink(
//                        destination: BookmarkView()
//                    ) {
//                        Image(systemName: "bookmark")
//                    }
//                }
//            }
//            .navigationTitle("카르카손").navigationBarTitleDisplayMode(.inline)
//        }.navigationBarBackButtonHidden(true)
//
//    }
//}
//
//#Preview {
//    MainRuleBook()
//        .modelContainer(for: Item.self, inMemory: true)
//}
