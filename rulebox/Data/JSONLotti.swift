//
//  JSONLotti.swift
//  rulebox
//
//  Created by Hama on 6/5/25.
//

import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    let filename: String

    func makeUIView(context: Context) -> some UIView {
        let animationView = LottieAnimationView(name: filename)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        return animationView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

/// JSON 파일 이름 넣기
// LottieView(filename: "Carca Basic_1_Setup_and_Components_1")
//    .frame(width: 706, height: 550)
