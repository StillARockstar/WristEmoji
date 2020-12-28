//
//  InfoViewProvider.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 19.12.20.
//

import Foundation

class InfoViewProvider: ObservableObject {
    private let dataProvider: DataProvider
    let versionNumber: String
    let copyrightText: String

    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
        self.versionNumber = "\(Bundle.main.releaseVersionNumber) (\(Bundle.main.buildVersionNumber))"
        self.copyrightText = "© 2021 Michael Schoder"
    }
}
