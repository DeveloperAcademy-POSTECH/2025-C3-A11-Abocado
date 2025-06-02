//
//  Bookmark View.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//

import SwiftUI

// TODO: 디자인 - 하마, 개발 - 닉스
struct BookmarkView: View {
    var body: some View {
        VStack{
            Text("Bookmark")
        }
        .navigationTitle("북마크")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    BookmarkView()
}
