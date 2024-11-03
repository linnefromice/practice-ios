//
//  FriendList.swift
//  FriendsFavoriteMovies
//
//  Created by arata.haruyama on 2024/11/04.
//

import SwiftUI
import SwiftData

struct FriendList: View {
    @Query(sort: \Friend.name) private var friends: [Friend]
    @Environment(\.modelContext) private var context
    
    var body: some View {
        List {
            ForEach(friends) { friend in
                Text(friend.name)
            }
        }
    }
}

#Preview {
    FriendList()
        .modelContainer(SampleData.shared.modelContainer)
}
