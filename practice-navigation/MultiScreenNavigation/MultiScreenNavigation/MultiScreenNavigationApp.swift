//
//  MultiScreenNavigationApp.swift
//  MultiScreenNavigation
//
//  Created by arata.haruyama on 2024/11/25.
//

import SwiftUI

@main
struct MultiScreenNavigationApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init())
        }
    }
}
