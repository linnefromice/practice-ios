import SwiftUI

final class CounterViewModel: ObservableObject {
    @Published private(set) var count: Int = 0
    
    func increment() {
        count += 1
    }
}

public struct CounterScreen: View {
    @StateObject private var viewModel: CounterViewModel = .init()
    
    public init() {}
    
    public var body: some View {
        VStack {
            Text("\(viewModel.count)")
                .monospacedDigit()
            Button("+") {
                viewModel.increment()
            }
        }
        .font(.largeTitle)
    }
}

#Preview {
    CounterScreen()
}
