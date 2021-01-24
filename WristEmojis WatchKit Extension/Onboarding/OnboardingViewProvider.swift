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
            ),
            OnboardingPageProvider(
                headline: "Add new emoji",
                description: "Press on \"New Emoji\" to add one to your collection."
            ),
            OnboardingPageProvider(
                headline: "Set the emoji",
                description: "Select an emoji from the picker and set a name."
            ),
            OnboardingPageProvider(
                headline: "Set the complication",
                description: "Go back to your watch face and long press to edit. From there you set your emoji as a complication."
            )
        ]
    }
}

