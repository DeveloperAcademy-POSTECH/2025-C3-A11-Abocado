//
//  AbocadoTimer.swift
//  rulebox
//
//  Created by POS on 6/5/25.
//

import Foundation
import SwiftUI


struct AbocadoTimer: View {
    @StateObject private var vm = TimerViewModel()

    var body: some View {
        VStack(spacing: 40) {
            Spacer()

            // 시간 표시
            Text(vm.formattedTime())
                .font(.system(size: 72, weight: .bold, design: .monospaced))
                .padding()

            // 시간 설정 (Wheel Picker)
            if !vm.isRunning && vm.remainingTime == vm.originalTime {
                HStack {
                    Picker("분", selection: $vm.selectedMinutes) {
                        ForEach(0..<60) { Text("\($0)분") }
                    }
                    .frame(width: 100)
                    .clipped()

                    Picker("초", selection: $vm.selectedSeconds) {
                        ForEach(0..<60) { Text("\($0)초") }
                    }
                    .frame(width: 100)
                    .clipped()
                }
                .pickerStyle(WheelPickerStyle())
            }

            // 버튼
            HStack(spacing: 40) {
                Button(action: {
                    vm.startPause()
                }) {
                    Text(vm.isRunning ? "일시정지" : "시작")
                        .frame(width: 100, height: 44)
                        .background(Color.blue.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }

                Button(action: {
                    vm.reset()
                }) {
                    Text("리셋")
                        .frame(width: 100, height: 44)
                        .background(Color.gray.opacity(0.3))
                        .foregroundColor(.black)
                        .cornerRadius(12)
                }
                .disabled(vm.remainingTime == vm.originalTime && !vm.isRunning)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("타이머")
        .navigationBarTitleDisplayMode(.inline)
    }
}


//NavigationLink(destination: AbocadoTimer()) {
//    Circle()
//        .fill(.blue)
//        .frame(width: 44, height: 44)
//}
//.frame(maxWidth: .infinity, alignment: .leading)
