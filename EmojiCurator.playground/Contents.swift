import UIKit
import PlaygroundSupport



enum CuratorError: Error {
    case noFileContent
    case encodingFailed
    case urlOutputFailed
}

struct EmojiCategory: Encodable {
    let name: String
    let emojis: [EmojiData]
}

struct EmojiData: Encodable {
    let emoji: String
    let flavors: [String]?
}


let filePath = Bundle.main.path(forResource:"emojis_14_2", ofType: "txt")
let contentData = FileManager.default.contents(atPath: filePath!)
let content = String(data:contentData!, encoding:String.Encoding.utf8)



print("Processing: \(filePath!)")

guard let content = content else {
    print("Failed loading content")
    throw CuratorError.noFileContent
}
let splitContent = content.split(separator: "\n")
print("Found \(splitContent.count) lines")



var categories = [EmojiCategory]()

for (index, singleContent) in splitContent.enumerated() {
    if singleContent.starts(with: "-") {
        let categoryName = singleContent.replacingOccurrences(of: "-", with: "")
        let categoryEmojis = Array(splitContent[index + 1]).map({ String($0) })

        let category = EmojiCategory(
            name: categoryName,
            emojis: categoryEmojis
        )
        print("Built category: \(category.name) with emojis \(category.emojis.count)")
        categories.append(category)
    }
}

print("Built \(categories.count) categories")



let encoder = JSONEncoder()
guard let outputData = try? encoder.encode(categories) else {
    throw CuratorError.encodingFailed
}
print(String(data: outputData, encoding: .utf8) ?? "No output")
