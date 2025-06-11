//
//  CheckboxList.swift
//  rulebox
//
//  Created by Elena on 6/5/25.
//

import SwiftUI

struct CheckboxList: View {
    @State private var items: [CheckboxBase] = [
        CheckboxBase(title: "기본판", isChecked: false),
        CheckboxBase(title: "확장판 01", isChecked: true),
        CheckboxBase(title: "확장판 02", isChecked: false) //TODO: 확장판 이름 연결 필요
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach($items) { $item in
                CheckboxRow(item: $item)
            }
        }
        .padding()
    }
}

#Preview {
    CheckboxList()
    .background(.gray)
}
