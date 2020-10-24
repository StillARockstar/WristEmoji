//
//  View+Embed.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 24.10.20.
//

import SwiftUI

extension View {

    func embedInNavigation() -> NavigationView<Self> {
        NavigationView {
            self
        }
    }
}
