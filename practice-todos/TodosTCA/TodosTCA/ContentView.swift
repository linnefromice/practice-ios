//
//  ContentView.swift
//  TodosTCA
//
//  Created by arata.haruyama on 2024/10/30.
//

import SwiftUI

struct TodosListView: View {
    var body: some View {
        Text("List")
    }
}

struct TodosAddView: View {
    var body: some View {
        Text("Add")
    }
}

struct TodosRoot: View {
    var body: some View {
        TabView {
            TodosListView()
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
            TodosAddView()
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
