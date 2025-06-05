//
//  Splash.swift
//  rulebox
//
//  Created by Three on 6/5/25.
//

import SwiftUI
import Lottie

struct SplashView: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            GameSelectView()
        } else {
            VStack {
                Spacer()
                JSONLottieOnce(fileName: "Splash", loopMode: LottieLoopMode.playOnce)
                    .frame(width: 120, height: 120)
                    .padding(20)
                Spacer()
            }
            .background(Color("backGround"))
            .onAppear {
                // 2초 후 자동 전환
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

