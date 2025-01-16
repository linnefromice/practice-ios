import RiveRuntime
import SwiftUI

// ref: https://github.com/rive-app/rive-ios/tree/main/Demo-App/RiveExampleSPM
struct SplashScreen: View {
    @State var isPlaying = true

    var riveLogo = RiveViewModel(fileName: "rive_animation_logo", autoPlay: false)
    var tree = RiveViewModel(fileName: "windy_tree")
    var playButton = RiveViewModel(fileName: "play_pause", stateMachineName: "State Machine 1")
    var confetti = RiveViewModel(fileName: "confetti", stateMachineName: "State Machine 1")
    var rings = RiveViewModel(fileName: "interactive_rings", stateMachineName: "State Machine 1")

    var body: some View {
        ZStack {
            tree.view()
                .aspectRatio(contentMode: .fit)

            VStack {
                riveLogo.view()
                    .aspectRatio(contentMode: .fit)
                    .onAppear {
                        riveLogo.play()
                    }

                Spacer().frame(width: 1.0)
            }

            VStack {
                Spacer().frame(width: 1.0)
                Spacer().frame(width: 1.0)

                ZStack {
                    playButton.view()
                        .padding(70)

                    rings.view()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0.5)
                        .padding(30)
                        .onTapGesture { togglePlay() }
                        .onLongPressGesture { togglePlay() }
                }
            }

            VStack {
                confetti.view()
                    .onTapGesture {
                        if !riveLogo.isPlaying {
                            confetti.triggerInput("Trigger explosion")
                        }
                        riveLogo.play()
                    }

                Spacer().frame(width: 1.0)
            }
        }
        .ignoresSafeArea()
        .background(
            LinearGradient(
                colors: [.lightPurple, .darkPurple], startPoint: .top, endPoint: .bottom))
    }

    private func togglePlay() {
        isPlaying.toggle()
        if isPlaying {
            tree.play()
        } else {
            tree.pause()
        }
        playButton.setInput("Play", value: isPlaying)
    }
}

extension Color {
    static var lightPurple = Color(hue: 0.786, saturation: 0.528, brightness: 0.463)
    static var darkPurple = Color(hue: 0.748, saturation: 0.917, brightness: 0.189)
}

#Preview {
    SplashScreen()
}
