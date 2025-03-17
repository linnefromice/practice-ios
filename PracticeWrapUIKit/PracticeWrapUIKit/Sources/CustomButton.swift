import SwiftUI
import UIKit

struct CustomButton: UIViewRepresentable {
    let title: String
    let action: () -> Void
    var backgroundColor: UIColor = .systemBlue

    func makeUIView(context: Context) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

        // Add visual feedback for button press
        button.showsTouchWhenHighlighted = true

        // Add highlight effect when pressed
        button.setBackgroundImage(
            UIImage.withColor(backgroundColor.withAlphaComponent(0.8)), for: .highlighted)

        button.addTarget(
            context.coordinator,
            action: #selector(Coordinator.buttonTapped),
            for: .touchUpInside
        )
        return button
    }

    func updateUIView(_ uiView: UIButton, context: Context) {
        uiView.setTitle(title, for: .normal)
        uiView.backgroundColor = backgroundColor
        uiView.setBackgroundImage(
            UIImage.withColor(backgroundColor.withAlphaComponent(0.8)), for: .highlighted)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(action: action)
    }

    class Coordinator: NSObject {
        var action: () -> Void

        init(action: @escaping () -> Void) {
            self.action = action
        }

        @objc func buttonTapped() {
            action()
        }
    }
}

// Extension to create UIImage with solid color
extension UIImage {
    static func withColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image ?? UIImage()
        }
        return UIImage()
    }
}
