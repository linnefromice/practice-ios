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
}
