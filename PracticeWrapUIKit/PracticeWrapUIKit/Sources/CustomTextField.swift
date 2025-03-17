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
