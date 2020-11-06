//
//  EmojiGroupPicker.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 06.11.20.
//

import SwiftUI

struct EmojiGroupPicker: View {
    let availableGroups: [String]
    let selectedItemCallback: ((Int) -> Void)

    var body: some View {
        List(availableGroups.indices, id: \.self) { index in
            Button(availableGroups[index], action: {
                selectedItemCallback(index)
            })
        }
    }
}

struct EmojiGroupPicker_Previews: PreviewProvider {
    static var previews: some View {
        EmojiGroupPicker(
            availableGroups: ["First Group", "Second Group", "Third Group", "Fourth Group", "Fifth Group"],
            selectedItemCallback: { _ in }
        )
    }
}
