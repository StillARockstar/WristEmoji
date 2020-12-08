//
//  EmojiConfiguration.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 08.12.20.
//

import Foundation

typealias EmojiString = String

extension EmojiString {
    var unicode: String {
        guard let unicode = self.unicodeScalars.first?.value else {
            return ""
        }
        return String(unicode)
    }
}

struct EmojiConfiguration: Codable, Equatable {
    let id: String
    let emoji: EmojiString
    let name: String

    func encode() -> String? {
        guard let jsonData = try? JSONEncoder().encode(self) else {
            return nil
        }
        return String(data: jsonData, encoding: .utf8)
    }

    static func from(_ dataString: String) -> Self? {
        guard let data = dataString.data(using: .utf8) else {
            return nil
        }
        return try? JSONDecoder().decode(Self.self, from: data)
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
