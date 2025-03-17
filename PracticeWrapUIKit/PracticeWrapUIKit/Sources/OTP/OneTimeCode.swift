import Combine
import SwiftUI

extension View {
    public func oneTimeCodeStyle(
        size: (font: Int, x: Int, y: Int),
        accent: Color = Color.white,
        foreground: Color = Color.white,
        background: Color = Color.gray
    ) -> some View {
        self
            .font(.system(size: CGFloat(size.font)))
            .accentColor(accent)
            .foregroundStyle(foreground)
            .frame(width: CGFloat(size.x), height: CGFloat(size.y))
            .background(background)
    }
}

struct OneTimeCodeModifier: ViewModifier {
    @Binding var pin: String
    let size: (font: Int, x: Int, y: Int) = (14, 40, 48)
    let isFocused: Bool = false
    let isError: Bool = false

    var textLimit = 1

    func limitText(_ upper: Int) {
        if pin.count > upper {
            self.pin = String(pin.prefix(upper))
        }
    }

    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .onReceive(Just(pin)) { _ in limitText(textLimit) }
    }
}

extension View {
    public func inputFieldOverlayStyle(
        _ radius: CGFloat = 6,
        focused: Bool = false,
        isError: Bool = false
    ) -> some View {
        self
            .cornerRadius(radius)
            .overlay(
                RoundedRectangle(cornerRadius: radius)
                    .strokeBorder(
                        isError
                            ? Color.red
                            : focused ? Color.white : Color.gray,
                        lineWidth: 1
                    )
            )
    }
}

public struct OneTimeCodeAtom: View {
    @Binding private var pin: String
    let size: (font: Int, x: Int, y: Int) = (14, 40, 48)
    let isFocused: Bool
    let isError: Bool
    let onBackspace: (Bool) -> Void

    public init(
        pin: Binding<String>,
        isFocused: Bool = false,
        isError: Bool = false,
        onBackspace: @escaping (Bool) -> Void
    ) {
        self._pin = pin
        self.isFocused = isFocused
        self.isError = isError
        self.onBackspace = onBackspace
    }

    public var body: some View {
        BackspaceDetectionTextField(
            text: $pin,
            onBackspace: onBackspace
        )
            .modifier(OneTimeCodeModifier(pin: $pin))
            .oneTimeCodeStyle(size: size)
            .inputFieldOverlayStyle(
                focused: isFocused,
                isError: isError
            )

    }
}

enum FocusPin: Hashable {
    case pin(Int)
}

// TODO: support backspace detection
// https://www.reddit.com/r/SwiftUI/comments/1adr0ap/how_to_detect_delete_key_press_on_a_textfield/
public struct OneTimeCode: View {
    @Binding var code: String
    var isError: Bool
    let codeLength: Int
    let isInitialFocus: Bool

    @State private var pins: [String] = []
    @FocusState private var pinFocusState: FocusPin?

    public init(
        code: Binding<String>,
        codeLength: Int,
        isError: Bool,
        isInitialFocus: Bool = false
    ) {
        self.codeLength = codeLength
        self._code = code
        self._pins = State(initialValue: Array(repeating: "", count: codeLength))
        self.isError = isError
        self.isInitialFocus = isInitialFocus
    }

    public var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<codeLength, id: \.self) { idx in
                OneTimeCodeAtom(
                    pin: $pins[idx],
                    isFocused: pinFocusState == FocusPin.pin(idx),
                    isError: isError,
                    onBackspace: { _ in 
                        pins[idx] = ""
                        if idx > 0 {
                            pinFocusState = FocusPin.pin(idx - 1)
                        }
                    }
                )
                .onChange(of: pins[idx]) { _, _ in
                    print("onChange of \(idx) \(pins[idx])")
                    updateFocusStateAfterPinChange(idx)
                    updateCodeAfterPinChange()
                }
                .focused($pinFocusState, equals: FocusPin.pin(idx))
            }
        }
        .onAppear {
            if isInitialFocus {
                pinFocusState = FocusPin.pin(0)
            }
        }
    }

    private func updateFocusStateAfterPinChange(_ idx: Int) {
        let isBack = pins[idx].isEmpty
        if isBack && idx > 0 {
            return
        } else if idx < codeLength - 1 {
            pinFocusState = FocusPin.pin(idx + 1)
        } else {
            pinFocusState = nil
        }
    }

    private func updateCodeAfterPinChange() {
        code = pins.joined()
    }
}

#Preview {
    @Previewable @State var code: String = ""
    @Previewable @State var isError: Bool = false

    VStack(alignment: .center, spacing: 24) {
        OneTimeCode(
            code: $code,
            codeLength: 4,
            isError: isError
        )
        Toggle("$isError", isOn: $isError)
    }
    .padding()
}
