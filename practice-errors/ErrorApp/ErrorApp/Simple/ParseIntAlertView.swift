import SwiftUI

enum ParseIntError: Error {
    case empty
    case parseFailed
}

func parseNumberFromString(_ value: String) throws(ParseIntError) -> Int {
    guard !value.isEmpty else {
        throw ParseIntError.empty
    }
    guard let res = Int(value) else {
        throw ParseIntError.parseFailed
    }
    return res
}

struct ParseIntAlertView: View {
    @State var numText: String = ""
    @State var result: Int?
    @State var err: String?
    
    func executeParse() {
        result = nil
        err = nil
        do {
            result = try parseNumberFromString(numText)
        } catch {
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
    ParseIntAlertView()
        .environment(\.locale, .init(identifier: "en"))
}
