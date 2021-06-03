import Foundation
import UIKit

public extension String {
    private static let emojiSkinToneModifiers: [String] =  ["🏻", "🏼", "🏽", "🏾", "🏿"]
    private static let hardcodedNoSkinToneEmojis: [String] = ["🤝", "🤼‍♀️", "🤼", "🤼‍♂️"]
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
    private static let coupleHandlingEmojis: [String] = ["👫", "👭", "👬", "👩‍❤️‍👨", "👩‍❤️‍👩", "💑", "👨‍❤️‍👨", "👩‍❤️‍💋‍👨", "👩‍❤️‍💋‍👩", "💏", "👨‍❤️‍💋‍👨"]
    private static let coupleHandlingPrototypes: [String: String] = [
        "👫": "👩🏻‍🤝‍👨🏿",
        "👭": "👩🏻‍🤝‍👩🏿",
        "👬": "👨🏻‍🤝‍👨🏿",
        "👩‍❤️‍👨": "👩🏻‍❤️‍👨🏿",
        "👩‍❤️‍👩": "👩🏻‍❤️‍👩🏿",
        "💑": "🧑🏻‍❤️‍🧑🏿",
        "👨‍❤️‍👨": "👨🏻‍❤️‍👨🏿",
        "👩‍❤️‍💋‍👨": "👩🏻‍❤️‍💋‍👨🏿",
        "👩‍❤️‍💋‍👩": "👩🏻‍❤️‍💋‍👩🏿",
        "💏": "🧑🏻‍❤️‍💋‍🧑🏿",
        "👨‍❤️‍💋‍👨": "👨🏻‍❤️‍💋‍👨🏿"
    ]

    var allSkinToneModifiedEmojis: [String] {
        guard self.canHaveSkinToneModifier else {
            return []
        }
        if let hardcodedSkinToneEmojis = Self.hardcodedSkinToneEmojis[self] {
            return hardcodedSkinToneEmojis
        }
        if Self.coupleHandlingEmojis.contains(self) {
            return self.handleCouple(
                original: self,
                prototype: Self.coupleHandlingPrototypes[self]!
            )
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
        if Self.hardcodedNoSkinToneEmojis.contains(self) {
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

    func handleCouple(original: String, prototype: String) -> [String] {
        let prototypeScalars = prototype.unicodeScalars

        guard let firstSkinIdx = prototypeScalars.firstIndex(
            where: { String($0) == Self.emojiSkinToneModifiers.first! }
        ) else {
            return []
        }
        let firstSkinIndex = prototypeScalars.distance(
            from: prototypeScalars.startIndex,
            to: firstSkinIdx
        ) as Int

        guard let secondSkinIdx = prototype.unicodeScalars.firstIndex(
                where: { String($0) == Self.emojiSkinToneModifiers.last! }
        ) else {
            return []
        }
        let secondSkinIndex = prototypeScalars.distance(
            from: prototypeScalars.startIndex,
            to: secondSkinIdx
        ) as Int

        var results = [String]()
        results.append(original)
        for modifier0 in Self.emojiSkinToneModifiers {
            var newScalars = prototype.unicodeScalars.map({ String($0) })
            newScalars[firstSkinIndex] = modifier0
            for modifier1 in Self.emojiSkinToneModifiers {
                newScalars[secondSkinIndex] = modifier1
                let newChar = String(Character(newScalars.joined()))
                results.append(newChar)
            }
        }

        guard results.count == Self.emojiSkinToneModifiers.count * Self.emojiSkinToneModifiers.count + 1 else {
            print("failed applying couple logic on \(self) ==> Unhandled emoji variation")
            return []
        }
        return results
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

