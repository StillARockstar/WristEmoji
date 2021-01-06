//
//  DataProvider.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 26.10.20.
//

import Foundation

protocol DataProvider {
    var appData: AppData { get }
    var userData: UserData { get }
}

protocol AppData {
    var onboardingDone: Bool { get }

    func setOnboardingDone(_ flag: Bool)
}

protocol UserData {
    var configurations: [EmojiConfiguration] { get }
    var configurationsPublished: Published<[EmojiConfiguration]> { get }
    var configurationsPublisher: Published<[EmojiConfiguration]>.Publisher { get }

    func load()
    func addOrUpdate(configuration: EmojiConfiguration)
    func delete(uuid: String)
}

// - MARK: App Data Provider

class AppDataProvider: DataProvider {
    let appData: AppData
    let userData: UserData

    init() {
        self.appData = AppAppData()
        self.userData = AppUserData()
    }
}

class AppAppData: AppData {
    private(set) var onboardingDone: Bool

    init() {
        self.onboardingDone = DataStore.namespace(DataStoreConstants.namespace).get(key: DataStoreConstants.onboardingDoneKey) ?? false
    }

    func setOnboardingDone(_ flag: Bool) {
        self.onboardingDone = flag
        DataStore.namespace(DataStoreConstants.namespace).set(value: flag, for: DataStoreConstants.onboardingDoneKey)
    }

    private struct DataStoreConstants {
        static let namespace = "app_data"
        static let onboardingDoneKey = "onboarding_done"
    }
}

class AppUserData: UserData {
    @Published var configurations: [EmojiConfiguration] = []
    var configurationsPublished: Published<[EmojiConfiguration]> { _configurations }
    var configurationsPublisher: Published<[EmojiConfiguration]>.Publisher { $configurations }

    init() {
        self.configurations = []
        self.load()
    }

    func load() {
        self.configurations = DataStore.namespace(DataStoreConstants.namespace).get(key: DataStoreConstants.configurations) ?? []
    }

    func addOrUpdate(configuration: EmojiConfiguration) {
        if let configIndex = self.configurations.firstIndex(where: { $0 == configuration }) {
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
    let appData: AppData
    let userData: UserData

    init() {
        self.appData = AppAppData()
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

    func load() { }

    func addOrUpdate(configuration: EmojiConfiguration) { }

    func delete(uuid: String) { }
}
