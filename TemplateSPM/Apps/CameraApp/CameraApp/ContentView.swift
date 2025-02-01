//
//  ContentView.swift
//  CameraApp
//
//  Created by arata.haruyama on 2025/01/31.
//

import SwiftUI
import CoreCamera

struct ContentView: View {
    @State private var viewModel = ViewModel()

    var body: some View {
        CameraView(image: $viewModel.currentFrame)
            .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
