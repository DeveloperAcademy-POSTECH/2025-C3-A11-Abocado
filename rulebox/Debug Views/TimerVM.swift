//
//  TimerVM.swift
//  rulebox
//
//  Created by POS on 6/5/25.
//

import Foundation
import SwiftUI
import Combine

class TimerViewModel: ObservableObject {
    @Published var selectedMinutes: Int = 1
    @Published var selectedSeconds: Int = 0
    @Published var remainingTime: Int = 60 // default 1분
    @Published var isRunning: Bool = false

    
    private(set) var originalTime: Int = 60

    private var timer: AnyCancellable?

    func startPause() {
        if isRunning {
            pause()
        } else {
            if remainingTime == 0 {
                originalTime = selectedMinutes * 60 + selectedSeconds
                remainingTime = originalTime
            } else if remainingTime == originalTime {
                // 타이머를 처음 시작하는 경우
                originalTime = selectedMinutes * 60 + selectedSeconds
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
                    self.reset()
                }
            }
    }

    func pause() {
        isRunning = false
        timer?.cancel()
    }

    func reset() {
        pause()
        remainingTime = originalTime
    }

    func formattedTime() -> String {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    var isTimeSet: Bool {
        selectedMinutes > 0 || selectedSeconds > 0
    }
}
