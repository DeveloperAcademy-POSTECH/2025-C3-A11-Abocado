//
//  Search View.swift
//  rulebox
//
//  Created by Ken on 5/29/25.
//

import SwiftUI

struct SearchView: View {
    
    @Environment(\.dismiss) private var dismiss

    
    @State private var searchText: String = ""
    
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        // Add dismiss or navigation logic here
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                            .imageScale(.large)
                    }
                    
                    TextField("자주 찾는 룰을 검색해보세요", text: $searchText)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8).onSubmit {
                            // 검색하기
                        }
                }
                .padding()
                ScrollView {
                    Text("111111111111111111111111111111111111111111111111111111111111111111111111")
                    Text("111111112")
                    Text("111111113")
                    Text("111111114")
                }.padding()

                Spacer()
            }
        }
    }
}

#Preview {
    SearchView()
        .modelContainer(for: Item.self, inMemory: true)
}
