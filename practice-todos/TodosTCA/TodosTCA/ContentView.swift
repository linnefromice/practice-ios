//
//  ContentView.swift
//  TodosTCA
//
//  Created by arata.haruyama on 2024/10/30.
//

import ComposableArchitecture
import SwiftUI

struct Todo: Identifiable, Hashable {
    let id: UUID
    let title: String
    let description: String?
    let assignee: String?
}

@Reducer
struct TodosFeature {
    @ObservableState
    struct State: Equatable {
        var todos: IdentifiedArrayOf<Todo> = []
    }
    enum Action {
        case addButtonTapped(Todo)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .addButtonTapped(todo):
                state.todos.append(todo)
                return .none
            }
        }
    }
}

struct TodosListView: View {
    let store: StoreOf<TodosFeature>

    var body: some View {
        List(store.todos) { todo in
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
    let store: StoreOf<TodosFeature>
    @State var title: String = ""
    @State var description: String = ""
    @State var assignee: String = ""
    
    func addTodo() {
        if title.isEmpty { return }
        let todo = Todo(
            id: UUID(),
            title: title,
            description: description.isEmpty ? "Todo \(store.todos.count + 1)" : description,
            assignee: assignee.isEmpty ? nil : assignee
        )
        store.send(.addButtonTapped(todo))
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
    let store: StoreOf<TodosFeature>
    
    
    var body: some View {
        TabView {
            TodosListView(store: store)
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
            TodosAddView(store: store)
                .tabItem {
                    Label("Add", systemImage: "plus")
                }
        }
    }
}


struct ContentView: View {
    static let store = Store(initialState: TodosFeature.State()) {
        TodosFeature()
                ._printChanges()
        }

    var body: some View {
        TodosRoot(store: Self.store)
    }
}

#Preview {
    TodosRoot(
        store: Store(initialState: TodosFeature.State(
            todos: [
                Todo(id: UUID(), title: "Todo 1", description: nil, assignee: "Tom"),
                Todo(id: UUID(), title: "Todo 2", description: nil, assignee: "Tom"),
                Todo(id: UUID(), title: "Todo 3", description: nil, assignee: "Jake"),
                Todo(id: UUID(), title: "Todo 4", description: nil, assignee: nil),
                Todo(id: UUID(), title: "Todo 5", description: nil, assignee: "Arisa"),
            ]
        )) {
            TodosFeature()._printChanges()
        }
    )
}
