//
//  Main Rule Filter.swift
//  rulebox
//
//  Created by POS on 6/5/25.
//

import Foundation
import SwiftUI

struct FilterSection: View {
    var filterTags: [FilterTag]
    @ObservedObject var vm: MainRuleBookVM
    
    @State private var showEFModal = false
    @State private var showPFModal = false

    var body: some View {
        HStack {
            Button{
                showEFModal = true
            } label: {
                EFCapsule(count: vm.selectedExtensions.count)
            }
            .sheet(isPresented: $showEFModal) {
                TypoTestView()
                    .presentationDetents([.medium, .large])
            }
            
            Button{
                showPFModal = true
            } label: {
                PFCapsule(selectedValue: vm.selectedParty ?? "선택되지 않음")
            }
            .sheet(isPresented: $showPFModal) {
                TypoTestView()
                    .presentationDetents([.medium, .large])
            }
//            DisclosureGroup("확장 추가: \(vm.selectedExtensions.count)개") {
//                ForEach(extensionValues, id: \.self) { value in
//                    Button(action: { vm.toggleExtension(value) }) {
//                        HStack {
//                            Text(value)
//                            if vm.selectedExtensions.contains(value) {
//                                Image(systemName: "checkmark")
//                            }
//                        }
//                    }
//                }
//            }
//            .background(
//                Color.atomicOpacity20
//            )
//            .clipShape(
//                RoundedRectangle(cornerRadius: 10)
//            )
//
//            DisclosureGroup("인원수 필터") {
//                ForEach(partyValues, id: \.self) { value in
//                    Button(action: { vm.selectedParty = value }) {
//                        HStack {
//                            Text(value)
//                            if vm.selectedParty == value {
//                                Image(systemName: "checkmark")
//                            }
//                        }
//
//                    }
//                }
//            }.background(
//                Color.atomicOpacity20
//            )
//            .clipShape(
//                RoundedRectangle(cornerRadius: 10)
//            )
        }
    }
}

/// Extension Filter Capsule
struct EFCapsule: View {
    var count: Int
    
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            Text("확장 추가")
              .font(
                Font.custom("Wanted Sans", size: 14)
                  .weight(.medium)
              )
              .foregroundColor(.white)
            
            Text("\(count)개")
              .font(
                Font.custom("Wanted Sans", size: 14)
                  .weight(.medium)
              )
              .foregroundColor(.red)
            
            Image("caret.down")
              .frame(width: 24, height: 24)
            
            
             }
        .padding(.leading, 12)
        .padding(.trailing, 6)
        .padding(.vertical, 6)
        .frame(height: 36, alignment: .leading)
        .background(.white.opacity(0.2))
        .cornerRadius(10)
    }
}

/// Party Filter Capsule
struct PFCapsule: View {
    var selectedValue: String
    
    var body: some View {
            HStack(alignment: .center, spacing: 4) {
                Text("\(selectedValue)명")
                    .font(Font.custom("Wanted Sans", size: 14).weight(.medium))
                    .foregroundColor(.white)
                
                Image("caret.down")
                    .frame(width: 24, height: 24)
            }
            .padding(.leading, 12)
            .padding(.trailing, 6)
            .padding(.vertical, 6)
            .frame(height: 36)
            .background(.white.opacity(0.2))
            .cornerRadius(10)
        }
}

