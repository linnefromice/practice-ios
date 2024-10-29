//
//  ContentView.swift
//  TodosRaw
//
//  Created by arata.haruyama on 2024/10/29.
//

import SwiftUI

struct Todo: Identifiable, Hashable {
    let id: UUID
    let title: String
    let description: String?
    let assignee: String?
}

let TODOS: [Todo] = [
    Todo(id: UUID(), title: "Todo 1", description: nil, assignee: "Tom"),
    Todo(id: UUID(), title: "Todo 2", description: nil, assignee: "Tom"),
    Todo(id: UUID(), title: "Todo 3", description: nil, assignee: "Jake"),
    Todo(id: UUID(), title: "Todo 4", description: nil, assignee: nil),
    Todo(id: UUID(), title: "Todo 5", description: nil, assignee: "Arisa"),
]

struct TodosListView: View {
    @Binding var todos: [Todo]

    var body: some View {
        List(todos) { todo in
            HStack {
                Text(todo.title)
                if let assignee = todo.assignee {
                    Spacer()
                    Text(assignee)
                }
            }
        }
    }
}


struct TodosAddView: View {
    @Binding var todos: [Todo]
    
    var body: some View {
        HStack {
            Button {
                let todo = Todo(
                    id: UUID(),
                    title: "Todo \(todos.count + 1)",
                    description: nil,
                    assignee: nil
                )
                todos.append(todo)
            } label: {
                Text("Add")
            }
        }
    }
}

struct TodosRoot: View {
    @State private var todosState: [Todo] = TODOS
    
    var body: some View {
        TabView {
            TodosListView(todos: $todosState)
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
            TodosAddView(todos: $todosState)
                .tabItem {
                    Label("Add", systemImage: "plus")
                }
        }
    }
}

struct ContentView: View {
    var body: some View {
        TodosRoot()
    }
}

#Preview {
    ContentView()
}
