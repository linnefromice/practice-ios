import SwiftUI

enum ParseIntError: Error {
    case empty
    case parseFailed
}

func parseNumberFromString(_ value: String) -> Int {
    if value.isEmpty {
        // todo: throw
    }
    if let res = Int(value) {
        return res
    } else {
        // todo: throw
        return 0
    }
}

struct ParseIntAlertView: View {
    @State var numText: String = ""
    @State var result: Int?
    
    func executeParse() {
        result = parseNumberFromString(numText)
    }
    
    var body: some View {
        VStack {
            TextField("TextToParseInt", text: $numText)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button("Parse") {
                print(Int(numText) ?? 0)
            }
        }
        .padding()
    }
}

#Preview {
    ParseIntAlertView()
        .environment(\.locale, .init(identifier: "en"))
}
