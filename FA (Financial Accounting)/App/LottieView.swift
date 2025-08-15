//
//  LaunchScreen.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 24.07.2025.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    private let name: String
    private let onComplete: () -> Void

    public init(name: String, onComplete: @escaping () -> Void) {
        self.name = name
        self.onComplete = onComplete
    }

    public func makeUIView(context: Context) -> LottieAnimationView {
        let v = LottieAnimationView()
        let bundle = Bundle.main

        v.animation = LottieAnimation.named(name, bundle: bundle)
        v.contentMode = .scaleAspectFit
        v.loopMode = .playOnce
        v.play { finished in if finished { onComplete() } }
        return v
    }

    public func updateUIView(_ uiView: LottieAnimationView, context: Context) {}
}

