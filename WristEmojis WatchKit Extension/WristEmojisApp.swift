//
//  WristEmojisApp.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 22.10.20.
//

import SwiftUI
import Combine
import ClockKit

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
    private let configurationsPublisher: AnyCancellable
    let dataProvider: DataProvider

    override init() {
        self.dataProvider = AppDataProvider()

        self.configurationsPublisher = dataProvider.userData.configurationsPublisher.sink { newValue in
            CLKComplicationServer.sharedInstance().activeComplications?.forEach {
                CLKComplicationServer.sharedInstance().reloadTimeline(for: $0)
            }
            CLKComplicationServer.sharedInstance().reloadComplicationDescriptors()
        }
    }

    func applicationDidBecomeActive() {
        self.dataProvider.userData.load()
    }
}
