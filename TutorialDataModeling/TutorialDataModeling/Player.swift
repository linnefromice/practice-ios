//
//  Player.swift
//  TutorialDataModeling
//
//  Created by arata.haruyama on 2024/11/02.
//

import Foundation
import SwiftUI

struct Player: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var score: Int
    var color: Color
}
