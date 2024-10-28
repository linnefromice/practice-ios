//
//  NumberFactClient.swift
//  TCATutorial
//
//  Created by arata.haruyama on 2024/10/28.
//

import ComposableArchitecture
import Foundation

struct NumberFactClient {
    var fetch: (Int) async throws -> String
}

extension NumberFactClient: DependencyKey {
    static let liveValue = Self(
        fetch: { number in
            let (data, _) = try await URLSession.shared
                .data(from: URL(string: "http://numbersapi.com/\(number)")!)
            return String(decoding: data, as: UTF8.self)
        }
    )
}

extension DependencyValues {
    var numberFact: NumberFactClient {
        get { self[NumberFactClient.self] }
        set { self[NumberFactClient.self] = newValue }
    }
}
