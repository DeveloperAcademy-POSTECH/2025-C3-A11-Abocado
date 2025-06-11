//
//  CheckboxList.swift
//  rulebox
//
//  Created by Elena on 6/5/25.
//

import SwiftUI

struct CheckboxRow: View {
    @Binding var item: CheckboxBase

    var body: some View {
        HStack {
            Image(item.isChecked ? "checkbox.selected" : "checkbox.unselected")
                .resizable()
                .frame(width: 24, height: 24)
                .onTapGesture {
                    item.isChecked.toggle()
                }
            Text(item.title)
                .font(.lgRegular)
                .foregroundColor(Color.grayNeutral95)
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

