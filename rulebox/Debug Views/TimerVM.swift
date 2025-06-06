//
//  TimerVM.swift
//  rulebox
//
//  Created by POS on 6/5/25.
//

import AudioToolbox
import Combine
import SwiftUI

class TimerViewModel: ObservableObject {
    @Published var selectedMinutes: Int = 0 { didSet { updateTimeFromSelection() }}
    @Published var selectedSeconds: Int = 40 { didSet { updateTimeFromSelection() }}

    @Published var remainingTime: Int
    @Published var isRunning: Bool = false

    private(set) var lastSetTime: Int
    
    private var timer: AnyCancellable?

    init() {
        self.remainingTime = 40
        self.lastSetTime = 40
    }

    func startPause() {
        if isRunning {
            pause()
        } else {
            lastSetTime = selectedMinutes * 60 + selectedSeconds
            if remainingTime == 0 || remainingTime == lastSetTime {
                remainingTime = lastSetTime
            }
            start()
        }
    }

    private func start() {
        isRunning = true
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.remainingTime > 0 {
                    self.remainingTime -= 1
                } else {
                    self.pause()
                    self.playEndSound()
                }
            }
    }

    private func playEndSound() {
        // 시스템 사운드 코드 사용
        AudioServicesPlaySystemSound(1005)
    }

    private func updateTimeFromSelection() {
        guard !isRunning else { return }
        let total = selectedMinutes * 60 + selectedSeconds
        lastSetTime = total
        remainingTime = total
    }

    func pause() {
        isRunning = false
        timer?.cancel()
    }

    func reset() {
        remainingTime = lastSetTime
    }

    func formattedTime() -> String {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    var isInitialState: Bool {
        !isRunning && remainingTime == lastSetTime
    }
}
