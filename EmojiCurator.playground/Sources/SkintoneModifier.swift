import Foundation
import UIKit

public extension String {
    private static let emojiSkinToneModifiers: [String] =  ["🏻", "🏼", "🏽", "🏾", "🏿"]
    private static let hardcodedSkinToneEmojis: [String: [String]] = [
        "🕵️‍♀️": ["🕵️‍♀️", "🕵🏻‍♀️", "🕵🏼‍♀️", "🕵🏽‍♀️", "🕵🏾‍♀️", "🕵🏿‍♀️"],
        "🕵️‍♂️": ["🕵️‍♂️", "🕵🏻‍♂️", "🕵🏼‍♂️", "🕵🏽‍♂️", "🕵🏾‍♂️", "🕵🏿‍♂️"],
        "🏋️‍♀️": ["🏋️‍♀️", "🏋🏻‍♀️", "🏋🏼‍♀️", "🏋🏽‍♀️", "🏋🏾‍♀️", "🏋🏿‍♀️"],
        "🏋️‍♂️": ["🏋️‍♂️", "🏋🏻‍♂️", "🏋🏼‍♂️", "🏋🏽‍♂️", "🏋🏾‍♂️", "🏋🏿‍♂️"],
        "⛹️‍♀️": ["⛹️‍♀️", "⛹🏻‍♀️", "⛹🏼‍♀️", "⛹🏽‍♀️", "⛹🏾‍♀️", "⛹🏿‍♀️"],
        "⛹️‍♂️": ["⛹️‍♂️", "⛹🏻‍♂️", "⛹🏼‍♂️", "⛹🏽‍♂️", "⛹🏾‍♂️", "⛹🏿‍♂️"],
        "🏌️‍♀️": ["🏌️‍♀️", "🏌🏻‍♀️", "🏌🏼‍♀️", "🏌🏽‍♀️", "🏌🏾‍♀️", "🏌🏿‍♀️"],
        "🏌️‍♂️": ["🏌️‍♂️", "🏌🏻‍♂️", "🏌🏼‍♂️", "🏌🏽‍♂️", "🏌🏾‍♂️", "🏌🏿‍♂️"]
    ]

    var allSkinToneModifiedEmojis: [String] {
        guard self.canHaveSkinToneModifier else {
            return []
        }
        if let hardcodedSkinToneEmojis = Self.hardcodedSkinToneEmojis[self] {
            print("failed applying on \(self) ==> Using hardcoded emojis")
            return hardcodedSkinToneEmojis
        }

        var emojis = [String]()
        emojis.append(self)
        for modifier in Self.emojiSkinToneModifiers {
            guard let modifiedEmoji = self.apply(modifier: modifier) else {
                print("failed applying on \(self) ==> Unhandled emoji variation")
                return []
            }
            emojis.append(modifiedEmoji)
        }

        return emojis
    }

    private var canHaveSkinToneModifier: Bool {
        guard !isEmpty else {
            return false
        }

        let modified = self.apply(modifier: Self.emojiSkinToneModifiers.first!) ?? ""
        return self != modified
    }

    private func apply(modifier: String) -> String? {
        var result = ""
        for scalar in self.unicodeScalars {
            if scalar.properties.isEmojiModifierBase {
                result.append("\(scalar)" + modifier)
            } else {
                result.append("\(scalar)")
            }
        }

        let charResult = String(Character(result))
        if self.glyphSize != charResult.glyphSize {
            return nil
        }

        return String(Character(result))
    }
}

private extension String {
    var glyphSize: CGSize {
        return (self as NSString)
            .boundingRect(
                with: CGSize(
                    width : CGFloat.greatestFiniteMagnitude,
                    height: .greatestFiniteMagnitude
                ),
                options: .usesLineFragmentOrigin,
                context: nil)
            .size
    }
}



