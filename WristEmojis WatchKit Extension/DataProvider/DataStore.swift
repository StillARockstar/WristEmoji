//
//  DataStore.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 26.10.20.
//

import Foundation

final class DataStore {
    private let namespace: String
    private var cache: [String: Data] = [:]

    private init(namespace: String) {
        self.namespace = namespace
        self.cache = self.loadCache()
    }

    static func namespace(_ namespace: String) -> DataStore {
        return DataStore(namespace: namespace)
    }

    func set<T: Codable>(value: T, for key: String) {
        self.cache[key] = try? JSONEncoder().encode(value)
        self.saveCache()
    }

    func get<U: Codable>(key: String) -> U? {
        guard let value = self.cache[key] else {
            return nil
        }
        return try? JSONDecoder().decode(U.self, from: value)
    }

    private func loadCache() -> [String: Data] {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return [:]
        }
        let pathWithFilename = documentDirectory.appendingPathComponent("\(self.namespace).json")

        do {
            let jsonData = try Data(contentsOf: pathWithFilename)
            return try JSONDecoder().decode([String: Data].self, from: jsonData)
        } catch {
            return [:]
        }
    }

    private func saveCache() {
        guard let jsonData = try? JSONEncoder().encode(self.cache),
              let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }

        do {
            let pathWithFilename = documentDirectory.appendingPathComponent("\(self.namespace).json")
            try jsonData.write(to: pathWithFilename)
        } catch { }
    }
}
