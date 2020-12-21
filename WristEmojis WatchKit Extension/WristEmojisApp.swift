//
//  WristEmojisApp.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 22.10.20.
//

import SwiftUI
import Combine

@main
struct WristEmojisApp: App {
    @WKExtensionDelegateAdaptor(ExtensionDelegate.self) var extensionDelegate

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(HomeViewProvider(dataProvider: extensionDelegate.dataProvider))
                .embedInNavigation()
        }
    }
}

class ExtensionDelegate: NSObject, WKExtensionDelegate {
    let dataProvider: DataProvider

    override init() {
        self.dataProvider = AppDataProvider()
    }

    func applicationDidBecomeActive() {
        self.dataProvider.userData.load()
    }
}
