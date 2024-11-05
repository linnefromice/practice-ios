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
        NavigationSplitView {
            List {
                ForEach(friends) { friend in
                    NavigationLink(friend.name) {
                        FriendDetail(friend: friend)
                    }
                }
            }
            .navigationTitle("Friends")
        } detail: {
            Text("Select a friend")
                .navigationTitle("Friend")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FriendList()
        .modelContainer(SampleData.shared.modelContainer)
}
