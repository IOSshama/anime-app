//
//  InteractivePopGestureModifier.swift
//  AnimeApp
//
//  Created by Шамхан Дандаев on 29.06.2026.
//

import SwiftUI
import UIKit

private struct InteractivePopGestureEnabler: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        GestureViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        uiViewController.enableInteractivePopGesture()
    }
}

private final class GestureViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        enableInteractivePopGesture()
    }
}

private extension UIViewController {
    func enableInteractivePopGesture() {
        guard let navigationController else {
            return
        }

        navigationController.interactivePopGestureRecognizer?.isEnabled = true
        navigationController.interactivePopGestureRecognizer?.delegate = nil
    }
}

extension View {
    func interactivePopGestureEnabled() -> some View {
        background(InteractivePopGestureEnabler())
    }
}
