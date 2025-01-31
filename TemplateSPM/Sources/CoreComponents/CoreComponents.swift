import SwiftUI

public struct ThreeSectionBar<Left, Center, Right>: View
where Left: View, Center: View, Right: View {
    public let left: () -> Left
    public let center: () -> Center
    public let right: () -> Right

    public init(
        left: @escaping () -> Left,
        center: @escaping () -> Center,
        right: @escaping () -> Right
    ) {
        self.left = left
        self.center = center
        self.right = right
    }

    public var body: some View {
        ZStack {
            HStack {
                left()
                Spacer()
            }
            center()
            HStack {
                Spacer()
                right()
            }
        }
    }
}

#Preview {
    VStack {
        ThreeSectionBar(
            left: { Image(systemName: "chevron.left") },
            center: { Text("Title") },
            right: { Image(systemName: "chevron.right") }
        )
            .padding()
        Spacer()
    }
}
