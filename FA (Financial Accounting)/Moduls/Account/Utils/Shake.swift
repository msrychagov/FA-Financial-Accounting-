// ShakeDetector.swift
import SwiftUI

// UIViewControllerRepresentable для отслеживания тряски устройства
struct ShakeDetector: UIViewControllerRepresentable {
    let onShake: () -> Void

    func makeUIViewController(context: Context) -> ShakeViewController {
        let vc = ShakeViewController()
        vc.onShake = onShake
        return vc
    }

    func updateUIViewController(_ uiViewController: ShakeViewController, context: Context) {}

    class ShakeViewController: UIViewController {
        var onShake: (() -> Void)?
        override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
            super.motionEnded(motion, with: event)
            if motion == .motionShake {
                onShake?()
            }
        }
    }
}
