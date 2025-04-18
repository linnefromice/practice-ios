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
    @State var title: String = ""
    @State var description: String = ""
    @State var assignee: String = ""
    
    func addTodo() {
        if title.isEmpty { return }
        let todo = Todo(
            id: UUID(),
            title: title,
            description: description.isEmpty ? nil : description,
            assignee: assignee.isEmpty ? nil : assignee
        )
        todos.append(todo)
        title = ""
        description = ""
        assignee = ""
    }

    var body: some View {
        Form {
            LabeledContent {
              TextField("Title", text: $title, prompt: Text("Required"))
            } label: {
              Text("Title")
            }
            LabeledContent {
              TextField("Description", text: $description, prompt: Text("Optional"))
            } label: {
              Text("Description")
            }
            LabeledContent {
              TextField("Assignee", text: $assignee, prompt: Text("Optional"))
            } label: {
              Text("Assignee")
            }
            Button {
                addTodo()
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
