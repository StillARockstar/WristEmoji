//
//  OnboardingViewProvider.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 06.01.21.
//

import Foundation
import Combine

struct OnboardingPageProvider: Identifiable {
    let id = UUID()
    let headline: String
    let description: String
}

class OnboardingViewProvider: ObservableObject {
    let pages: [OnboardingPageProvider]

    init() {
        self.pages = [
            OnboardingPageProvider(
                headline: "Welcome to WristEmojis",
                description: "Express Yourself with emojis."
            )
        ]
    }
}

