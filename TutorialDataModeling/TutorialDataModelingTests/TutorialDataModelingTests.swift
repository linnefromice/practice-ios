//
//  TutorialDataModelingTests.swift
//  TutorialDataModelingTests
//
//  Created by arata.haruyama on 2024/11/02.
//

import Testing
@testable import TutorialDataModeling

struct TutorialDataModelingTests {

    @Test("Reset player scores", arguments: [0, 10, 20])
    func resetStores(to newValue: Int) async throws {
        var scoreboard = Scoreboard(players: [
            Player(name: "Elisha", score: 0),
            Player(name: "Andre", score: 5),
        ])
        scoreboard.resetScores(to: newValue)
        
        for player in scoreboard.players {
            #expect(player.score == newValue)
        }
    }
    
    @Test("Highest score wins")
    func highestScoreWins() {
        let scoreboard = Scoreboard(
            players: [
                Player(name: "Elisha", score: 0),
                Player(name: "Andre", score: 4),
            ],
            state: .gameOver,
            doesHighestScoreWin: true
        )
        
        let winners = scoreboard.winners
        #expect(winners == [Player(name: "Andre", score: 4)])
    }
    
    @Test("Lowest score wins")
    func lowestScoreWins() {
        let scoreboard = Scoreboard(
            players: [
                Player(name: "Elisha", score: 0),
                Player(name: "Andre", score: 4),
            ],
            state: .gameOver,
            doesHighestScoreWin: false
        )
        
        let winners = scoreboard.winners
        #expect(winners == [Player(name: "Elisha", score: 0)])
    }
}