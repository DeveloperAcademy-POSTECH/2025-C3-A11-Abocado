//
//  Main Rule Filter.swift
//  rulebox
//
//  Created by POS on 6/5/25.
//
// TODO: 이거 왜 optionLabel이 있는거에요.............

import Foundation
import SwiftUI

struct ExtensionFilterView: View {
    var filterTags: [FilterTag]
    @ObservedObject var vm: MainRuleBookVM
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        let extensionValues = vm.extensionValues(from: filterTags)

        VStack(alignment: .center, spacing: 2) {
            Text("게임 버전").font(.smHeading)
            Text("기본판은 필수 선택입니다").font(.mdRegular).foregroundColor(
                .grayNeutral70
            ).padding(.bottom, 18)
            Divider()
                .background(Color.atomicOpacity25)

            VStack(alignment: .leading, spacing: 12) {
                ForEach(extensionValues, id: \.self) { value in
                    Button(action: { vm.toggleExtension(value) }) {
                        HStack {

                            (vm.selectedExtensions.contains(value)
                                ? AnyView(CheckboxSelectedIcon)
                                : AnyView(CheckboxUnSelectedIcon))
                                .frame(width: 24, height: 24)
                                .foregroundStyle(
                                    vm.selectedExtensions.contains(value)
                                        ? Color.primaryNormal
                                        : Color.grayNeutral30
                                )
                            Text(value)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                    }
                }
                Spacer()
            }.frame(maxHeight: .infinity)

            Button(action: {
                dismiss()
            }) {
                Text("확인")
                    .font(.lgRegular)
                    .frame(maxWidth: .infinity)
                    .frame(height: 51)
                    .foregroundColor(.white)
                    .background(Color.primaryNormal)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 12)
        }
        .padding(.horizontal, 0)
        .padding(.top, 50)
        .padding(.bottom, 12)
        .frame(maxWidth: .infinity, alignment: .top)
    }
}

struct PartyFilterView: View {
    @State private var selected: Int
    @ObservedObject var vm: MainRuleBookVM
    @Environment(\.dismiss) private var dismiss

    init(vm: MainRuleBookVM) {
        self.vm = vm
        self._selected = State(initialValue: Int(vm.selectedParty ?? "2") ?? 1)
    }

    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Text("게임 인원").font(.smHeading)
            Text("플레이 인원을 선택해주세요").font(.mdRegular).foregroundColor(
                .grayNeutral70
            ).padding(.bottom, 18)
            Divider()
                .background(Color.atomicOpacity25)

            VStack(alignment: .leading, spacing: 12) {
                ForEach(2...5, id: \.self) { index in
                    Button(action: {
                        selected = index
                    }) {
                        HStack {
                            (selected == index
                                ? AnyView(
                                    ZStack {
                                        Image("radio.base").renderingMode(
                                            .template
                                        )
                                        .foregroundStyle(
                                            Color.primaryNormal
                                        )
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 2)
                                        radioEllipseIcon
                                    }
                                )
                                : AnyView(radioBaseIcon))
                                .frame(width: 24, height: 24)
                                .foregroundStyle(
                                    selected == index
                                        ? Color.primaryNormal
                                        : Color.grayNeutral30
                                )

                            Text(optionLabel(for: index))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            Spacer()
                        }.padding(.horizontal, 20).padding(.vertical, 12)
                    }
                }

            }.frame(maxHeight: .infinity)

            Button(action: {
                vm.selectedParty = selected.formatted()
                dismiss()
            }) {
                Text("확인")
                    .font(.lgRegular)
                    .frame(maxWidth: .infinity)
                    .frame(height: 51)
                    .foregroundColor(.white)
                    .background(Color.primaryNormal)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 12)
        }
        .padding(.horizontal, 0)
        .padding(.top, 50)
        .padding(.bottom, 12)
        .frame(maxWidth: .infinity, alignment: .top)

    }
}

func optionLabel(for index: Int) -> String {
    switch index {
    case 1: return "1명"
    case 2: return "2명"
    case 3: return "3명"
    case 4: return "4명"
    case 5: return "5명"
    case 6: return "6명"
    default: return ""
    }
}
