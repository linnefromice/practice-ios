import SwiftUI

func parseNumberResultFromString(_ value: String) -> Result<Int, ParseIntError> {
    guard !value.isEmpty else {
        return .failure(.empty)
    }
    guard let res = Int(value) else {
        return .failure(.parseFailed)
    }
    return .success(res)
}

struct ParseIntResultAlertView: View {
    @State var numText: String = ""
    @State var result: Int?
    @State var err: String?
    
    func executeParse() {
        result = nil
        err = nil
        switch parseNumberResultFromString(numText) {
        case .success(let value):
            result = value
        case .failure(let error):
            switch error {
            case .empty:
                err = "Empty string"
            case .parseFailed:
                err = "Failed to parse"
            }
        }
    }
    
    var body: some View {
        VStack {
            TextField("TextToParseInt", text: $numText)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button("Parse") {
                executeParse()
            }
            if let res = result {
                Text("Result")
                Text(String(res))
            }
        }
        .padding()
        .alert(
            "Error",
            isPresented: Binding(
                get: { err != nil },
                set: { if !$0 { err = nil }}
            ),
            presenting: err
        ) { err in
            Button("OK", role: .cancel) {}
        } message: { err in
            Text(err)
        }
    }
}

#Preview {
    ParseIntResultAlertView()
        .environment(\.locale, .init(identifier: "en"))
}
