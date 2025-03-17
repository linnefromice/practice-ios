import SwiftUI
import UIKit

struct CustomTextField: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var keyboardType: UIKeyboardType = .default
    var returnKeyType: UIReturnKeyType = .default
    var isSecureTextEntry: Bool = false
    var autocapitalizationType: UITextAutocapitalizationType = .none
    var autocorrectionType: UITextAutocorrectionType = .default
    var onCommit: (() -> Void)?

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        textField.keyboardType = keyboardType
        textField.returnKeyType = returnKeyType
        textField.isSecureTextEntry = isSecureTextEntry
        textField.autocapitalizationType = autocapitalizationType
        textField.autocorrectionType = autocorrectionType
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)

        // Improve text visibility with darker text color
        textField.textColor = UIColor.darkText

        // Add visual feedback when editing
        textField.backgroundColor = UIColor(white: 0.97, alpha: 1.0)
        textField.tintColor = UIColor.systemBlue  // Cursor color

        // Add border
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 5.0

        // Add a toolbar with a "Done" button
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done, target: context.coordinator,
            action: #selector(Coordinator.doneButtonTapped))
        toolbar.items = [flexSpace, doneButton]
        textField.inputAccessoryView = toolbar

        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, onCommit: onCommit)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        var onCommit: (() -> Void)?

        init(text: Binding<String>, onCommit: (() -> Void)?) {
            self._text = text
            self.onCommit = onCommit
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            // Add visual feedback when editing begins
            textField.backgroundColor = UIColor(white: 0.95, alpha: 1.0)

            // Change border color when focused
            textField.layer.borderColor = UIColor.systemBlue.cgColor
            textField.layer.borderWidth = 2.0

            // Add subtle animation for focus
            UIView.animate(withDuration: 0.2) {
                textField.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
            }
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            // Reset background when editing ends
            textField.backgroundColor = UIColor(white: 0.97, alpha: 1.0)

            // Reset border when not focused
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.borderWidth = 1.0

            // Reset transform
            UIView.animate(withDuration: 0.2) {
                textField.transform = CGAffineTransform.identity
            }
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            onCommit?()
            return true
        }

        @objc func doneButtonTapped() {
            UIApplication.shared.sendAction(
                #selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            onCommit?()
        }
    }
}
