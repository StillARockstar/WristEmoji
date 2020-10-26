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

    let dataProvider: DataProvider
    let configuration: EmojiConfiguration?
    let deleteable: Bool

    init(dataProvider: DataProvider, configuration: EmojiConfiguration?, deleteable: Bool) {
        self.dataProvider = dataProvider
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

    func save() {
        let uuid = self.configuration?.id ?? UUID().uuidString
        self.dataProvider.userData.addOrUpdate(
            configuration: EmojiConfiguration(id: uuid, emoji: emoji, name: name)
        )
    }

    func delete() {
        let uuid = self.configuration?.id ?? UUID().uuidString
        self.dataProvider.userData.delete(uuid: uuid)
    }
}
