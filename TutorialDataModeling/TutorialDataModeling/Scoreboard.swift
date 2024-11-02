//
//  Scoreboard.swift
//  TutorialDataModeling
//
//  Created by arata.haruyama on 2024/11/02.
//

import Foundation

struct Scoreboard {
    var players: [Player] = [
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
    
    var state = GameState.setup
    
    mutating func resetScores(to newValue: Int) {
        
    }
}
