//
//  HomeViewProvider.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 22.10.20.
//

import Foundation
import Combine

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
