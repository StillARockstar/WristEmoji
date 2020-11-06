//
//  DataProvider.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 26.10.20.
//

import Foundation

protocol DataProvider {
    var userData: UserData { get }
}

protocol UserData {
    var configurations: [EmojiConfiguration] { get }
    var configurationsPublished: Published<[EmojiConfiguration]> { get }
    var configurationsPublisher: Published<[EmojiConfiguration]>.Publisher { get }

    func addOrUpdate(configuration: EmojiConfiguration)
    func delete(uuid: String)
}

// - MARK: App Data Provider

class AppDataProvider: DataProvider {
    let userData: UserData

    init() {
        self.userData = AppUserData()
    }
}

class AppUserData: UserData {
    @Published var configurations: [EmojiConfiguration] = []
    var configurationsPublished: Published<[EmojiConfiguration]> { _configurations }
    var configurationsPublisher: Published<[EmojiConfiguration]>.Publisher { $configurations }

    init() {
        self.configurations = DataStore.namespace(DataStoreConstants.namespace).get(key: DataStoreConstants.configurations) ?? []
    }

    func addOrUpdate(configuration: EmojiConfiguration) {
        if let configIndex = self.configurations.firstIndex(where: { $0.id == configuration.id }) {
            self.configurations[configIndex] = configuration
            DataStore.namespace(DataStoreConstants.namespace).set(value: self.configurations, for: DataStoreConstants.configurations)
        } else {
            self.configurations.append(configuration)
            DataStore.namespace(DataStoreConstants.namespace).set(value: self.configurations, for: DataStoreConstants.configurations)
        }
    }

    func delete(uuid: String) {
        self.configurations.removeAll(where: { $0.id == uuid })
        DataStore.namespace(DataStoreConstants.namespace).set(value: self.configurations, for: DataStoreConstants.configurations)
    }

    private struct DataStoreConstants {
        static let namespace = "user_data"
        static let configurations = "configs"
    }
}

// - MARK: Prview Data Provider

class PreviewDataProvider: DataProvider {
    let userData: UserData

    init() {
        self.userData = PreviewUserData()
    }
}

class PreviewUserData: UserData {
    @Published var configurations: [EmojiConfiguration] = []
    var configurationsPublished: Published<[EmojiConfiguration]> { _configurations }
    var configurationsPublisher: Published<[EmojiConfiguration]>.Publisher { $configurations }

    init() {
        self.configurations = [
            EmojiConfiguration(id: UUID().uuidString, emoji: "🚀", name: "Rocket"),
            EmojiConfiguration(id: UUID().uuidString, emoji: "🦁", name: "Rawwwr"),
            EmojiConfiguration(id: UUID().uuidString, emoji: "🐶", name: "Doggo"),
            EmojiConfiguration(id: UUID().uuidString, emoji: "🥳", name: "Party")
        ]

    }

    func addOrUpdate(configuration: EmojiConfiguration) {

    }

    func delete(uuid: String) {

    }
}
