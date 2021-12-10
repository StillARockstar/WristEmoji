//
//  OnboardingView.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 06.01.21.
//

import SwiftUI

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var provider: OnboardingViewProvider
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        TabView {
            ForEach(provider.pages, content: { pageProvider in
                OnboardingPageView(provider: pageProvider)
            })
            OnboardingDoneView(action: {
                presentationMode.wrappedValue.dismiss()
            })
        }
        .tabViewStyle(PageTabViewStyle())
    }
}

private struct OnboardingPageView: View {
    let provider: OnboardingPageProvider

    var body: some View {
        VStack(spacing: 5) {
            Text(LocalizedStringKey(provider.headline))
                .font(.headline)
                .foregroundColor(.accentColor)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
            Text(LocalizedStringKey(provider.description))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
            Spacer()
        }
        .padding(.top, 5)
    }
}

private struct OnboardingDoneView: View {
    let action: () -> Void

    var body: some View {
        VStack {
            Text("onboarding.done.title")
                .font(.headline)
                .foregroundColor(.accentColor)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 5)
            Button("onboarding.done.button", action: action)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(OnboardingViewProvider())
    }
}
