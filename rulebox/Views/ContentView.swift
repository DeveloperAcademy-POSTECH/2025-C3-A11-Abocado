//
//  ContentView.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//

import SwiftData
import SwiftUI


struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        GameSelectView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
