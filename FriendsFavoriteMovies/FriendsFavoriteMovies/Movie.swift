//
//  Friend.swift
//  FriendsFavoriteMovies
//
//  Created by arata.haruyama on 2024/11/04.
//

import Foundation
import SwiftData

@Model
class Movie {
    var title: String
    var releaseDate: Date
    
    init(title: String, releaseDate: Date) {
        self.title = title
        self.releaseDate = releaseDate
    }
}
