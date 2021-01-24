//
//  EmojiPicker.swift
//  WristEmojis WatchKit Extension
//
//  Created by Michael Schoder on 06.11.20.
//

import SwiftUI

private struct EmojiPickerGridItem: Hashable {
    let label: String
    let doesNavigate: Bool
}

struct EmojiPicker: View {
    @State var showsFlavorSelection: Bool = false
    @State var selectedEmojiRepresentation: EmojiRepresentation?
    @Environment(\.presentationMode) var presentationMode
    let selectedEmojiCallback: ((String) -> Void)

    init(selectedEmojiCallback: @escaping ((String) -> Void)) {
        self.selectedEmojiCallback = selectedEmojiCallback
    }

    var body: some View {
        NavigationView {
            List(EmojisModel.availableGroups.indices, id: \.self) { index in
                let groupName = EmojisModel.availableGroups[index]
                let representations = EmojisModel.emojisForGroup(groupName: groupName)
                NavigationLink(
                    destination: EmojiPickerGrid(
                        availableEmojiGridItems: representations.map({ EmojiPickerGridItem(label: $0.emoji, doesNavigate: !$0.flavors.isEmpty) }),
                        selectedEmojiCallback: { index in
                            let representation = representations[index]
                            selectedEmojiCallback(representation.emoji)
                            presentationMode.wrappedValue.dismiss()
                        },
                        navigationDestination: { index in
                            let representation = representations[index]
                            guard !representation.flavors.isEmpty else { return nil }

                            return EmojiPickerGrid(
                                availableEmojiGridItems: representation.flavors.map({ EmojiPickerGridItem(label: $0, doesNavigate: false)}),
                                selectedEmojiCallback: { index in
                                    selectedEmojiCallback(representation.flavors[index])
                                    presentationMode.wrappedValue.dismiss()
                                },
                                navigationDestination: nil
                            ).asAnyView()
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
    let availableEmojiGridItems: [EmojiPickerGridItem]
    let selectedEmojiCallback: ((Int) -> Void)
    let navigationDestination: ((Int) -> AnyView?)

    init(availableEmojiGridItems: [EmojiPickerGridItem], selectedEmojiCallback: @escaping ((Int) -> Void), navigationDestination: ((Int) -> AnyView?)?) {
        self.availableEmojiGridItems = availableEmojiGridItems
        self.selectedEmojiCallback = selectedEmojiCallback
        self.navigationDestination = navigationDestination ?? { _ in Text("Something went wrong").asAnyView() }
    }

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(availableEmojiGridItems, id: \.self) { item in
                    let index = availableEmojiGridItems.firstIndex(of: item) ?? 0
                    if item.doesNavigate {
                        NavigationLink(item.label, destination: navigationDestination(index))
                            .font(.title)
                            .aspectRatio(contentMode: .fill)
                    } else {
                        Button(item.label, action: {
                            selectedEmojiCallback(index)
                        })
                        .font(.title)
                        .aspectRatio(contentMode: .fill)
                    }
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
