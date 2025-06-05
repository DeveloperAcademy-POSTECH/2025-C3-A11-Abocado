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
            VStack(spacing: 0) {
                Spacer()
                JSONLottieOnce(fileName: "Splash", loopMode: LottieLoopMode.playOnce)
                    .frame(width: 120, height: 120)
                    .padding(20)
                
                // 텍스트 (설명 문구)
                Text("보드게임 규칙을 내 손안에")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(Color.primaryNormal)  // 예: 주황색
                    .padding(.top, 12)
                Spacer()
                // 앱 이름 (하단)
                Text("RuleBox")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color.primaryNormal)
                    .padding(.bottom, 42)
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

