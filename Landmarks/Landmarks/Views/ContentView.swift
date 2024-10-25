//
//  ContentView.swift
//  Landmarks
//
//  Created by arata.haruyama on 2024/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
