//
//  TCATutorialNavigationApp.swift
//  TCATutorialNavigation
//
//  Created by arata.haruyama on 2024/10/29.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCATutorialNavigationApp: App {
    static let store = Store(initialState: ContactsFeature.State()) {
            ContactsFeature()
                ._printChanges()
        }
    
    var body: some Scene {
        WindowGroup {
            ContactsView(
                store: Self.store
            )
        }
    }
}
