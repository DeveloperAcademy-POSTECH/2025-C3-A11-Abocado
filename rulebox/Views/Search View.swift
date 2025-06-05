//
//  Search View.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        NavigationStack {
            Text("Search View")
        }
    }
}

#Preview {
    SearchView()
        .modelContainer(for: Item.self, inMemory: true)
}
