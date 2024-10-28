//
//  TCATutorialApp.swift
//  TCATutorial
//
//  Created by arata.haruyama on 2024/10/28.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCATutorialApp: App {
    static let store = Store(initialState: CounterFeature.State()) {
      CounterFeature()
            ._printChanges()
    }

    var body: some Scene {
        WindowGroup {
            CounterView(
                store: Self.store
            )
        }
    }
}
