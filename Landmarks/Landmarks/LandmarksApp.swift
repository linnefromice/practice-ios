//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by arata.haruyama on 2024/10/24.
//

import SwiftUI

@main
struct LandmarksApp: App {
    @State private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
        }
    }
}
