//
//  WristEmojisApp.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 22.10.20.
//

import SwiftUI

@main
struct WristEmojisApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(HomeViewProvider(dataProvider: AppDataProvider()))
                .embedInNavigation()
        }
    }
}
