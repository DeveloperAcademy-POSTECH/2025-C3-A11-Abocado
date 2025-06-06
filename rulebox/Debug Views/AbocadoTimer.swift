//
//  AbocadoTimer.swift
//  rulebox
//
//  Created by POS on 6/5/25.
//

import SwiftUI


struct AbocadoTimer: View {
    @StateObject private var vm = TimerViewModel()
    
    var body: some View {
        VStack(spacing: 32) {
            /// for Reset button
            let isDisabled = !vm.isRunning && vm.remainingTime == vm.lastSetTime
            
            Spacer()

            // Time picker
            if !vm.isRunning {
                HStack(spacing: 30) {
                    Picker("분", selection: $vm.selectedMinutes) {
                        ForEach(0..<60) { Text("\($0)").tag($0) }
                    }
                    .labelsHidden()
                    .frame(width: 100)
                    .clipped()

                    Text(":")
                        .font(.system(size: 40, weight: .bold))
                    
                    Picker("초", selection: $vm.selectedSeconds) {
                        ForEach(0..<60) { Text("\($0)").tag($0) }
                    }
                    .labelsHidden()
                    .frame(width: 100)
                    .clipped()
                }
                .pickerStyle(WheelPickerStyle())
            }
            else {
                // showing time
                Text(vm.formattedTime())
                    .font(.system(size: 80, weight: .semibold, design: .rounded))
                    .monospacedDigit()
                    .frame(height: 100)
            }
            
            HStack(spacing: 40) {
                Button(action: {
                    vm.reset()
                }) {
                    Text("리셋")
                        .font(.headline)
                        .frame(width: 100, height: 44)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(isDisabled)
                .opacity(isDisabled ? 0.2 : 1.0) 

                Button(action: {
                    vm.startPause()
                }) {
                    Text(vm.isRunning ? "일시정지" : "시작")
                        .font(.headline)
                        .frame(width: 100, height: 44)
                        .background(vm.isRunning ? Color.orange : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }

            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 20)
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
