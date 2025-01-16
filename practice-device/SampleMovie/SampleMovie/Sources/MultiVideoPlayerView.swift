import SwiftUI

public struct MultiVideoPlayerView: View {
    public init() {}

    public var body: some View {
        ZStack {
            HStack(spacing: 4) {
                VideoPlayerView(width: 160, height: 120)
                VideoPlayerView(width: 160, height: 120)
                VideoPlayerView(width: 160, height: 120)
            }
            .rotationEffect(.degrees(4))
            .offset(y: -64)

            HStack(spacing: 4) {
                VideoPlayerView(width: 160, height: 120)
                VideoPlayerView(width: 160, height: 120)
                VideoPlayerView(width: 160, height: 120)
            }
            .rotationEffect(.degrees(-4))
            .offset(y: 64)
        }
    }
}

#Preview {
    MultiVideoPlayerView()
}
