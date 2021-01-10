import Foundation
import UIKit

public extension String {
    private static let emojiSkinToneModifiers: [String] =  ["🏻", "🏼", "🏽", "🏾", "🏿"]

    private var emojiUnmodified: String {
        if isEmpty {
            return self
        }
        let string = String(self.unicodeScalars.first!)
        return string
    }

    private var glyphSize: CGSize {
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

    private var canHaveSkinToneModifier: Bool {
        guard !isEmpty else {
            return false
        }

        let modified = self.emojiUnmodified + Self.emojiSkinToneModifiers[0]
        return self.emojiUnmodified.glyphSize == modified.glyphSize
    }

    var allSkinToneModifiedEmojis: [String]? {
        guard self.canHaveSkinToneModifier else {
            return nil
        }
        var emojis = [String]()
        emojis.append(self)
        for modifier in Self.emojiSkinToneModifiers {
            emojis.append(self.emojiUnmodified + modifier)
        }
        return emojis
    }
}
