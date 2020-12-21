//
//  DetailViewPovider.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 22.10.20.
//

import Foundation
import Combine
import ClockKit

enum DetailViewMode {
    case create
    case view
}

class DetailViewProvider: ObservableObject {
    @Published var emoji: String
    @Published var name: String

    let dataProvider: DataProvider
    let configuration: EmojiConfiguration?
    let mode: DetailViewMode

    init(dataProvider: DataProvider, configuration: EmojiConfiguration?, mode: DetailViewMode) {
        self.dataProvider = dataProvider
        self.configuration = configuration
        self.mode = mode

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
        self.updateClockKit()
    }

    func delete() {
        let uuid = self.configuration?.id ?? UUID().uuidString
        self.dataProvider.userData.delete(uuid: uuid)
        self.updateClockKit()
    }

    private func updateClockKit() {
        CLKComplicationServer.sharedInstance().activeComplications?.forEach {
            CLKComplicationServer.sharedInstance().reloadTimeline(for: $0)
        }
        CLKComplicationServer.sharedInstance().reloadComplicationDescriptors()
    }
}
