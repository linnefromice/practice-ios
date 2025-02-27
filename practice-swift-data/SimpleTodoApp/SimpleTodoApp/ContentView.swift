//
//  ContentView.swift
//  SimpleTodoApp
//
//  Created by arata.haruyama on 2025/02/27.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        ContentViewContents()
            .modelContainer(for: [
                Todo.self,
                User.self,
                Team.self,
            ])
    }
}

let DUMMY_USER_NAMES: [String] = [
    "Alice",
    "Bob",
    "Charlie",
    "Dave",
    "Eve",
    "Frank",
    "George",
    "Alice",
    "Bob",
    "Jim",
    "Jill",
]

struct ContentViewContents: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            TodoListView()
                .tabItem {
                    Label("Todo", systemImage: "checklist")
                }
                .tag(0)

            UserListView()
                .tabItem {
                    Label("ユーザー", systemImage: "person.2")
                }
                .tag(1)
        }
        .onAppear {
            setupInitialData()
        }
    }

    private func setupInitialData() {
        // ユーザーデータの初期化
        let userCount = try! modelContext.fetchCount(FetchDescriptor<User>())
        if userCount == 0 {
            for name in DUMMY_USER_NAMES {
                let user = User(name: name)
                modelContext.insert(user)
            }
            try! modelContext.save()

            // サンプルTodoの追加
            let users = try! modelContext.fetch(FetchDescriptor<User>())
            let shuffledUsers = users.shuffled()
            let todo1 = Todo(title: "買い物に行く", assigneeIds: [shuffledUsers[0].id])
            let todo2 = Todo(
                title: "レポートを書く", assigneeIds: [shuffledUsers[1].id, shuffledUsers[2].id])
            modelContext.insert(todo1)
            modelContext.insert(todo2)
            try! modelContext.save()
        }
    }
}

#Preview {
    ContentView()
}
