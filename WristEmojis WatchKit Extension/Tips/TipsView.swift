//
//  DonationsView.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 25.10.21.
//

import SwiftUI

struct TipsView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("You like WristEmojis? Help me out keeping my Apps free 🙏")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                TipsButton(emoji: "🪙", label: "Some Tip", amount: "0.99€", action: {})
                TipsButton(emoji: "☕️", label: "Coffee", amount: "2.99€", action: {})
                TipsButton(emoji: "🍹", label: "Fancy Drink", amount: "9.99€", action: {})
                TipsButton(emoji: "🌮", label: "Taco Dinner", amount: "19.99€", action: {})
            }
        }
    }
}

private struct TipsButton: View {
    let emoji: String
    let label: String
    let amount: String
    let action: () -> Void

    var body: some View {
        Button(
            action: action,
            label: {
                HStack(spacing: 10) {
                    Text(emoji)
                        .font(.title2)
                    VStack(alignment: .leading) {
                        Text(label)
                        Text(amount)
                            .font(.footnote)
                    }
                    Spacer()
                }
                .padding(.leading, 4)
            }
        )
    }
}

struct DonationsView_Previews: PreviewProvider {
    static var previews: some View {
        TipsView()
    }
}
