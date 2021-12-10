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
                headline: "onboarding.welcome.title",
                description: "onboarding.welcome.text"
            ),
            OnboardingPageProvider(
                headline: "onboarding.addEmoji.title",
                description: "onboarding.addEmoji.text"
            ),
            OnboardingPageProvider(
                headline: "onboarding.setEmoji.title",
                description: "onboarding.setEmoji.text"
            ),
            OnboardingPageProvider(
                headline: "onboarding.complication.title",
                description: "onboarding.complication.text"
            )
        ]
    }
}

