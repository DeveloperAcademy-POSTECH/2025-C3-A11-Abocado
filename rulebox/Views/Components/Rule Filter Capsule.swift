//
//  Main Rule Filter.swift
//  rulebox
//
//  Created by POS on 6/5/25.
//

import Foundation
import SwiftUI

struct MainFilterSection: View {
    var filterTags: [FilterTag]
    @ObservedObject var vm: MainRuleBookVM

    @State private var showEFModal = false
    @State private var showPFModal = false

    var body: some View {
        HStack {
            Button {
                showEFModal = true
            } label: {
                EFCapsule(count: vm.selectedExtensions.count)
            }
            .sheet(isPresented: $showEFModal) {
                ExtensionFilterView(filterTags: filterTags, vm: vm)
                    .presentationDetents([.medium, .large])
            }

            Button {
                showPFModal = true
            } label: {
                PFCapsule(selectedValue: vm.selectedParty ?? "선택되지 않음")
            }
            .sheet(isPresented: $showPFModal) {
                PartyFilterView(vm: vm)
                    .presentationDetents([.medium, .large])
            }
        }
    }
}

struct PreFilterSection: View{
    var filterTags: [FilterTag]
    @ObservedObject var vm: MainRuleBookVM

    @State private var showEFModal = false
    @State private var showPFModal = false

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("버전")
            
            Button {
                showEFModal = true
            } label: {
                EFCapsule(count: vm.selectedExtensions.count)
            }
            .sheet(isPresented: $showEFModal) {
                ExtensionFilterView(filterTags: filterTags, vm: vm)
                    .presentationDetents([.medium, .large])
            }
            
            Text("인원수")
            
            Button {
                showPFModal = true
            } label: {
//                PFCapsule(selectedValue: vm.selectedParty ?? "선택되지 않음")
                PFCapsule(selectedValue: vm.selectedParty.map { "\($0)명" } ?? "선택되지 않음")

            }
            .sheet(isPresented: $showPFModal) {
                PartyFilterView(vm: vm)
                    .presentationDetents([.medium, .large])
            }
        }
        .padding(0)
        .frame(width: 357, alignment: .topLeading)
    }

}

/// Extension Filter Capsule
struct EFCapsule: View {
    var count: Int

    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            Text("확장 추가")
                .font(
                    .mdMedium
                )
                .foregroundColor(.white)
            
            let count_ = count - 1
            
            Text("\(count_)개") //기본판은 카운트에 포함하지 않음
                .font(
                    .mdMedium
                )
                .foregroundColor(.primaryNormal)

            Image("caret.down")
                .renderingMode(.template)
                .frame(width: 24, height: 24)
                .foregroundColor(.white)

        }

        .padding(.leading, 12)
        .padding(.trailing, 6)
        .padding(.vertical, 6)
        .frame(height: 36, alignment: .leading)
        .background(Color.atomicOpacity20)
        .cornerRadius(10)
    }
}

/// Party Filter Capsule
struct PFCapsule: View {
    var selectedValue: String

    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            Text("\(selectedValue)")
                .font(.mdMedium)
                .foregroundColor(.white)

            Image("caret.down")
                .renderingMode(.template)
                .frame(width: 24, height: 24)
                .foregroundColor(.white)
        }
        .padding(.leading, 12)
        .padding(.trailing, 6)
        .padding(.vertical, 6)
        .frame(height: 36)
        .background(Color.atomicOpacity20)
        .cornerRadius(10)
    }
}
