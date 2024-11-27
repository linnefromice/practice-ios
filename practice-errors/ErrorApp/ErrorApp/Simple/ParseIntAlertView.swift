import SwiftUI

enum ParseIntError: Error {
    case empty
    case parseFailed
}

func parseNumberFromString(_ value: String) throws -> Int {
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
    
    func executeParse() {
        do {
            result = try parseNumberFromString(numText)
        } catch {
            result = nil
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
                Text(String(res))
            }
        }
        .padding()
    }
}

#Preview {
    ParseIntAlertView()
        .environment(\.locale, .init(identifier: "en"))
}
