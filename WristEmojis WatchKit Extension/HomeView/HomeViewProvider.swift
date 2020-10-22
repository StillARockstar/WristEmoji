//
//  HomeViewProvider.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 22.10.20.
//

import Foundation
import Combine

struct EmojiConfiguration {
    let id: String
    let emoji: String
    let name: String
}

class HomeViewProvider: ObservableObject {
    @Published var entries: [EmojiConfiguration]

    init() {
        self.entries = [
            EmojiConfiguration(id: UUID().uuidString, emoji: "🚀", name: "Rocket"),
            EmojiConfiguration(id: UUID().uuidString, emoji: "🦁", name: "Rawwwr"),
            EmojiConfiguration(id: UUID().uuidString, emoji: "🐶", name: "Doggo"),
            EmojiConfiguration(id: UUID().uuidString, emoji: "🥳", name: "Party")
        ]
    }
}
