//
//  DetailViewPovider.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 22.10.20.
//

import Foundation
import Combine

class DetailViewProvider: ObservableObject {
    @Published var emoji: String
    @Published var name: String

    let configuration: EmojiConfiguration?
    let deleteable: Bool

    init(configuration: EmojiConfiguration?, deleteable: Bool) {
        self.configuration = configuration
        self.deleteable = deleteable

        if let configuration = configuration {
            self.emoji = configuration.emoji
            self.name = configuration.name
        } else {
            self.emoji = "🚀"
            self.name = ""
        }
    }
}
