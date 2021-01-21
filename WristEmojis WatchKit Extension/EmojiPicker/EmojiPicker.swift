//
//  EmojiPicker.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 06.11.20.
//

import SwiftUI

struct EmojiPicker: View {
    @Environment(\.presentationMode) var presentationMode
    let selectedEmojiCallback: ((String) -> Void)

    init(selectedEmojiCallback: @escaping ((String) -> Void)) {
        self.selectedEmojiCallback = selectedEmojiCallback
    }

    var body: some View {
        NavigationView {
            List(EmojisModel.availableGroups.indices, id: \.self) { index in
                let groupName = EmojisModel.availableGroups[index]
                NavigationLink(
                    destination: EmojiPickerGrid(
                        availableEmojis: EmojisModel.emojisForGroup(groupName: groupName).map({ $0.emoji }),
                        selectedEmojiCallback: { emoji in
                            selectedEmojiCallback(emoji)
                            presentationMode.wrappedValue.dismiss()
                        }
                    )
                ) {
                    Text(groupName)
                }
            }
        }
    }
}

private struct EmojiPickerGrid: View {
    let availableEmojis: [String]
    let selectedEmojiCallback: ((String) -> Void)

    init(availableEmojis: [String], selectedEmojiCallback: @escaping ((String) -> Void)) {
        self.availableEmojis = availableEmojis
        self.selectedEmojiCallback = selectedEmojiCallback
    }

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(availableEmojis, id: \.self) { item in
                    Button(item, action: {
                        selectedEmojiCallback(item)
                    })
                    .font(.title)
                    .aspectRatio(contentMode: .fill)
                }
            }
        }
    }
}

struct EmojiPicker_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPicker(selectedEmojiCallback: { _ in })
    }
}
