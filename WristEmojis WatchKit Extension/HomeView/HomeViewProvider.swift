//
//  HomeViewProvider.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 22.10.20.
//

import Foundation
import Combine

struct EmojiConfiguration: Codable, Equatable {
    let id: String
    let emoji: String
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

class HomeViewProvider: ObservableObject {
    let dataProvider: DataProvider
    private var subscriptions: Set<AnyCancellable> = Set()

    @Published var entries: [EmojiConfiguration] = []

    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
        dataProvider.userData.configurationsPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.entries, on: self)
            .store(in: &subscriptions)
    }
}
