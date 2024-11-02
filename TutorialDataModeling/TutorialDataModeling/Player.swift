//
//  Player.swift
//  TutorialDataModeling
//
//  Created by arata.haruyama on 2024/11/02.
//

import Foundation

struct Player: Identifiable {
    let id = UUID()
    var name: String
    var score: Int
}
