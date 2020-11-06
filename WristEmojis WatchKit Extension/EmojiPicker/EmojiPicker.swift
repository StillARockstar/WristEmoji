//
//  EmojiPicker.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 06.11.20.
//

import SwiftUI

struct EmojiPicker: View {
    var body: some View {
        EmojiGroupPicker(
            availableGroups: EmojisModel.availableGroups,
            selectedItemCallback: { index in
                print("Selected index: \(index)")
            }
        )
    }
}

struct EmojiPicker_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPicker()
    }
}
