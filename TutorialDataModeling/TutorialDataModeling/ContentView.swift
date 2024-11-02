//
//  ContentView.swift
//  TutorialDataModeling
//
//  Created by arata.haruyama on 2024/11/01.
//

import SwiftUI

struct ContentView: View {
    @State private var players: [Player] = [
        Player(
            name: "Elisha",
            score: 0
        ),
        Player(
            name: "Andre",
            score: 0
        ),
        Player(
            name: "Jasmine",
            score: 0
        )
    ]
    
    var body: some View {
        VStack {
            ForEach($players) { $player in
                TextField("Name", text: $player.name)
                Stepper("\(player.score)", value: $player.score)
            }
            Button("Add Player", systemImage: "plus") {
                players.append(Player(name: "", score: 0))
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
