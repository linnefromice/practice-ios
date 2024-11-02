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
            score: 0,
            color: Color.white
        ),
        Player(
            name: "Andre",
            score: 0,
            color: Color.white
        ),
        Player(
            name: "Jasmine",
            score: 0,
            color: Color.white
        )
    ]
    @State private var selectedPlayers: Set<Player> = []
    
    private func movePlayer(from source: IndexSet, to destination: Int) {
        players.move(fromOffsets: source, toOffset: destination)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Score Keeper")
                    .font(.title)
                    .bold()
                    .padding(.bottom)
                Spacer()
                EditButton()
            }

            HStack {
                Text("Player")
                    .gridColumnAlignment(.leading)
                Text("Score")
                Text("")
                Text("Color")
            }
            .font(.headline)
            List(selection: $selectedPlayers) {
                ForEach($players) { $player in
                    HStack {
                        TextField("Name", text: $player.name)
                        Text("\(player.score)")
                        Stepper("\(player.score)", value: $player.score)
                            .labelsHidden()
                        ColorPicker("Color", selection: $player.color)
                            .labelsHidden()
                    }
                    .background(player.color)
                }
                .onMove(perform: movePlayer)
            }
            Button("Add Player", systemImage: "plus") {
                players.append(Player(name: "", score: 0, color: Color.white))
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
