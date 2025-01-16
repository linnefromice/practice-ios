import SwiftUI
import AVKit

public struct VideoPlayerView: View {
//    let url = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!
//    @State var player = AVPlayer(url: url)

    @State var player = AVPlayer(url: Bundle.main.url(forResource: "ForBiggerJoyrides", withExtension: "mp4")!)

    let width: CGFloat
    let height: CGFloat

    public init(
        width: CGFloat = 400,
        height: CGFloat = 300
    ) {
        self.width = width
        self.height = height
    }

    public var body: some View {
        VideoPlayer(player: player) {
            // overlay
            Text("Video")
        }
            .frame(width: width, height: height, alignment: .center)
    }
}

#Preview {
    VideoPlayerView()
}
