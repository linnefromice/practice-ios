//
//  BirthdaysApp.swift
//  Birthdays
//
//  Created by arata.haruyama on 2024/11/02.
//

import SwiftUI
import SwiftData

@main
struct BirthdaysApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Friend.self)
        }
    }
}
