//
//  Toolbar View.swift
//  rulebox
//
//  Created by Ken on 6/4/25.
//

import SwiftUI

struct ToolbarView: View {
    @Environment(\.dismiss) private var dismiss

    let title: String
    let genres: [String]
    @Binding var isExapnded: Bool

    var body: some View {
        if isExapnded {

            ZStack {
                Image("carca")
                    .resizable()
                    .frame(width: 393, height: 393)
                VStack {
                    HStack {
                        Button(action: { dismiss() }) {
                            homeToolbarIcon
                        }
                        Spacer()
                        NavigationLink(destination: SearchView()) {
                            searchToolbarIcon
                        }
                        NavigationLink(destination: BookmarkView()) {
                            bookmarkToolbarIcon
                        }
                    }.padding(.horizontal, 18).padding(.vertical, 14)

                    ForEach(
                        genres,
                        id: \.self
                    ) { genre in
                        GenreCapsule(title: genre, isSelected: true)
                    }

                }
            }
        } else {

            ZStack {
                Image("carca")
                    .resizable()
                    .frame(width: 393, height: 393)
                Color.clear
                    .background(.ultraThinMaterial)
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Button(action: { dismiss() }) {
                            homeToolbarIcon
                        }
                        Spacer()
                        VStack(spacing: 4) {
                            Text(title)
                                .font(.mdMedium)
                            ForEach(
                                genres,
                                id: \.self
                            ) { genre in
                                Text(genre)
                                    .font(.smRegular)
                            }
                        }

                        Spacer()
                        NavigationLink(destination: SearchView()) {
                            searchToolbarIcon
                        }
                        NavigationLink(destination: BookmarkView()) {
                            bookmarkToolbarIcon
                        }
                    }.padding(.horizontal, 18).padding(.vertical, 14)

                }
            }
        }
    }
}
