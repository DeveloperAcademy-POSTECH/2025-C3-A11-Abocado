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

    var body: some View {
        GameSelectView()
            //TODO: global background colour 설정 왜안되는걸까요
            .background(Color.backGroundCol)
            .ignoresSafeArea()
    }
}

//#Preview {
//    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
//}
