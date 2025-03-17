import SwiftUI
import UIKit

struct BackspaceDetectionTextField: UIViewRepresentable {
  @Binding var text: String
  let onBackspace: (Bool) -> Void

  func makeCoordinator() -> BackspaceDetectionTextFieldCoordinator {
    BackspaceDetectionTextFieldCoordinator(textBinding: $text)
  }

  func makeUIView(context: Context) -> BackspaceDetectionUITextField {
    let view = BackspaceDetectionUITextField()
    view.delegate = context.coordinator
    view.keyboardType = .numberPad
    view.textAlignment = .center
    view.autocorrectionType = .no
    view.tintColor = .clear

    return view
  }

  func updateUIView(_ uiView: BackspaceDetectionUITextField, context: Context) {
    uiView.text = text
    uiView.onBackspace = onBackspace
  }

  // custom UITextField subclass that detects backspace events
  class BackspaceDetectionUITextField: UITextField {
    var onBackspace: ((Bool) -> Void)?

    override init(frame: CGRect) {
      onBackspace = nil
      super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
      fatalError()
    }

    override func deleteBackward() {
      onBackspace?(text?.isEmpty == true)
      super.deleteBackward()
    }
  }
}

// the coordinator is here to allow for mapping text to the
// binding using the delegate methods
class BackspaceDetectionTextFieldCoordinator: NSObject {
  let textBinding: Binding<String>

  init(textBinding: Binding<String>) {
    self.textBinding = textBinding
  }
}

extension BackspaceDetectionTextFieldCoordinator: UITextFieldDelegate {
  func textField(_ textField: UITextField, 
                 shouldChangeCharactersIn range: NSRange, 
                 replacementString newString: String) -> Bool {
    let currentText = textField.text
    if newString.isEmpty {
        textBinding.wrappedValue = currentText ?? ""
    } else {
        textBinding.wrappedValue = newString
    }
    return true
  }
}