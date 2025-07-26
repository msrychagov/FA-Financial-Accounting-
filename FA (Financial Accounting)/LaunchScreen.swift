//
//  LaunchScreen.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 24.07.2025.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let name: String
    let onComplete: () -> Void
    
    init(name: String, onComplete: @escaping () -> Void) {
        self.name = name
        self.onComplete = onComplete
    }
    
    func makeUIView(context: Context) -> LottieAnimationView {
        let view = LottieAnimationView(name: name)
        view.contentMode = .scaleAspectFit
        view.loopMode = .playOnce
        view.play { finished in
            if finished { onComplete() }
        }
        return view
    }
    
    func updateUIView(_ uiView: LottieAnimationView, context: Context) {}
}
