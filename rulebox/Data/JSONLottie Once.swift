//
//  JSONLottie Once.swift
//  rulebox
//
//  Created by Three on 6/5/25.
//

import SwiftUI
import Lottie

struct JSONLottieOnce: UIViewRepresentable {
    
    var fileName: String
    var loopMode: LottieLoopMode = .playOnce
   
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let lottieAnimationView = LottieAnimationView(name: fileName)
        lottieAnimationView.contentMode = .scaleAspectFit
        lottieAnimationView.loopMode = loopMode
        lottieAnimationView.play()
        lottieAnimationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lottieAnimationView)
        NSLayoutConstraint.activate([
            lottieAnimationView.widthAnchor.constraint(equalTo:view.widthAnchor),
            lottieAnimationView.heightAnchor.constraint(equalTo:view.heightAnchor)
        ])
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
