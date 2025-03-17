import SwiftUI

struct OneTimeCodeContainer: View {
    @Binding var code: String
    let codeLength: Int

    @State var remainingTimeForCode: Int
    let codeExpirySeconds: Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var error: String
    let isInitialFocus: Bool
    let onResendCode: (@escaping () -> Void) -> Void

    var isError: Bool {
        !error.isEmpty
    }

    func updateRemainingTimeForCode() {
        if remainingTimeForCode > 0 {
            remainingTimeForCode -= 1
        }
    }

    init(
        code: Binding<String>,
        codeLength: Int,
        codeExpirySeconds: Int = 60,
        error: String,
        isInitialFocus: Bool = false,
        onResendCode: @escaping (@escaping () -> Void) -> Void
    ) {
        self.codeLength = codeLength
        self._code = code
        self.codeExpirySeconds = codeExpirySeconds
        self._remainingTimeForCode = State(initialValue: codeExpirySeconds)
        self.error = error
        self.isInitialFocus = isInitialFocus
        self.onResendCode = onResendCode
    }

    var body: some View {
        VStack(spacing: 8) {
            OneTimeCode(
                code: $code,
                codeLength: codeLength,
                isError: isError,
                isInitialFocus: isInitialFocus
            )

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    if remainingTimeForCode > 0 {
                        Text("Resend code in \(remainingTimeForCode)s")
                            // .font(.textFont(11))
                            .foregroundColor(Color.gray)
                    } else {
                        Button(action: {
                            onResendCode({
                                // NOTE: reset remaining time for code
                                remainingTimeForCode = codeExpirySeconds
                            })
                        }) {
                            Text("Resend code")
                                // .font(.textFont(11))
                                .foregroundColor(Color.primary)
                        }
                        // TextButton(
                        //     variant: TextButtonVariant(
                        //         styleVariant: .primary,
                        //         state: .disable
                        //     ),
                        //     label: "Resend code",
                        //     action: {
                        //         onResendCode({
                        //             // NOTE: reset remaining time for code
                        //             remainingTimeForCode = codeExpirySeconds
                        //         })
                        //     }
                        // )
                    }
                    Spacer()
                }
                if isError {
                    HStack {
                        Text(error)
                            .font(.system(size: 12))
                            .foregroundColor(.red)
                        Spacer()
                    }
                }
            }
        }
        .onReceive(timer) { _ in
            updateRemainingTimeForCode()
        }
    }
}

#Preview {
    @Previewable @State var code: String = ""
    @Previewable @State var isError: Bool = false

    VStack(alignment: .center, spacing: 24) {
        OneTimeCodeContainer(
            code: $code,
            codeLength: 4,
            error: "",
            onResendCode: { _ in }
        )
        OneTimeCodeContainer(
            code: $code,
            codeLength: 4,
            codeExpirySeconds: 0,
            error: "The code is invalid",
            onResendCode: { _ in }
        )
    }
    .padding()
}
