//
//  ContentView.swift
//  TutorialObservation
//
//  Created by arata.haruyama on 2024/11/06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Task Manager")
              .font(
                Font.system(size: 54)
                    .weight(.bold)
              )
              .kerning(0.25)
              .foregroundColor(.black)
              .frame(maxHeight: .infinity)
        }
    }
}

#Preview {
    ContentView()
}
