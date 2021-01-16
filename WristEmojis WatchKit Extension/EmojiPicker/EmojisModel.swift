//
//  EmojiModel.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 06.11.20.
//

import Foundation
import WatchKit

private struct EmojiRepresentation: Codable {
    let emoji: String
    let flavors: [String]
}

private struct EmojiCategory: Codable {
    let name: String
    let emojis: [EmojiRepresentation]
}

class EmojisModel {
    static var availableGroups: [String] {
        return Self.emojiCategories.map({ $0.name })
    }

    static func emojisForGroup(groupName: String) -> [String] {
        return Self.emojiCategories.first(where: { $0.name == groupName })?.emojis.map({ $0.emoji }) ?? []
    }

    private static let emojiCategories: [EmojiCategory] = {
        let systemVersion = WKInterfaceDevice.current().systemVersion
        var emojiFileName = ""

        if systemVersion.starts(with: "7.1") {
            emojiFileName = "emojis_7_1"
        } else {
            emojiFileName = "emojis_7_0"
        }

        guard let filePath = Bundle.main.path(forResource: emojiFileName, ofType: "json"),
              let contentData = FileManager.default.contents(atPath: filePath) else {
            return []
        }
        return (try? JSONDecoder().decode([EmojiCategory].self, from: contentData)) ?? []
    }()
}
