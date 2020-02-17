import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let articles: [Article]
    let topics: [Topic]
}

// MARK: - Article
struct Article: Codable {
    let title: Title
    let mainText: MainText?
    let mainResource: MainResource?

    enum CodingKeys: String, CodingKey {
        case title
        case mainText
        case mainResource
    }
}

// MARK: - MainResource
struct MainResource: Codable {
    let imageAsset: ImageAsset

    enum CodingKeys: String, CodingKey {
        case imageAsset
    }
}

// MARK: - ImageAsset
struct ImageAsset: Codable {
    let id: String
}

// MARK: - MainText
struct MainText: Codable {
    let type: String
    let paragraphs: [Paragraph]
}

// MARK: - Paragraph
struct Paragraph: Codable {
    let text: Title
    let blockType: String

    enum CodingKeys: String, CodingKey {
        case text
        case blockType
    }
}

// MARK: - Title
struct Title: Codable {
    let value: String
}

// MARK: - Topic
struct Topic: Codable {
    let title, type: String
}
