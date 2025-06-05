//
//  AbocadoTimer.swift
//  rulebox
//
//  Created by POS on 6/5/25.
//

import Foundation
import SwiftUI

struct AbocadoTimer: View {
    @State private var minutes = 0
    @State private var seconds = 0
    @State private var totalTime = 0
    @State private var remainingTime = 0
    @State private var timerRunning = false
    @State private var timer: Timer?

    var body: some View {
        VStack(spacing: 40) {
            Text(timeString(from: remainingTime))
                .font(.system(size: 60, weight: .bold, design: .monospaced))

            if !timerRunning && remainingTime == 0 {
                HStack {
                    Picker("분", selection: $minutes) {
                        ForEach(0..<60) { Text("\($0)분") }
                    }
                    .frame(width: 100)
                    .clipped()
                    Picker("초", selection: $seconds) {
                        ForEach(0..<60) { Text("\($0)초") }
                    }
                    .frame(width: 100)
                    .clipped()
                }
                .pickerStyle(WheelPickerStyle())
            }

            HStack(spacing: 40) {
                Button(action: {
                    if timerRunning {
                        pauseTimer()
                    } else {
                        startTimer()
                    }
                }) {
                    Text(timerRunning ? "일시정지" : "시작")
                        .font(.title)
                        .frame(width: 120, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: resetTimer) {
                    Text("리셋")
                        .font(.title)
                        .frame(width: 120, height: 50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
    }

    func startTimer() {
        if remainingTime == 0 {
            totalTime = minutes * 60 + seconds
            remainingTime = totalTime
        }

        timerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                timer?.invalidate()
                timerRunning = false
            }
        }
    }

    func pauseTimer() {
        timer?.invalidate()
        timerRunning = false
    }

    func resetTimer() {
        timer?.invalidate()
        timerRunning = false
        remainingTime = 0
        minutes = 0
        seconds = 0
    }

    func timeString(from seconds: Int) -> String {
        let m = seconds / 60
        let s = seconds % 60
        return String(format: "%02d:%02d", m, s)
    }
}


//NavigationLink(destination: AbocadoTimer()) {
//    Circle()
//        .fill(.blue)
//        .frame(width: 44, height: 44)
//}
//.frame(maxWidth: .infinity, alignment: .leading)
