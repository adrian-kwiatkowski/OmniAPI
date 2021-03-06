import Foundation

protocol SearchResult {}

// MARK: - Welcome
struct Welcome: Codable {
    let articles: [Article]
    let topics: [Topic]
}

// MARK: - Article
struct Article: Codable, SearchResult {
    let title: Title
    let mainText: MainText
    private let mainResource: MainResource?
    
    var imageURL: URL? {
        guard let mainResource = mainResource, let imageAsset = mainResource.imageAsset else { return nil }
        var components = URLComponents()
        components.scheme = "https"
        components.host = "gfx-ios.omni.se"
        components.path = "/images/\(imageAsset.id)"
        return components.url
    }

    enum CodingKeys: String, CodingKey {
        case title
        case mainText = "main_text"
        case mainResource = "main_resource"
    }
}

// MARK: - MainResource
struct MainResource: Codable {
    let imageAsset: ImageAsset?

    enum CodingKeys: String, CodingKey {
        case imageAsset = "image_asset"
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
    let text: Title?
    let blockType: String

    enum CodingKeys: String, CodingKey {
        case text
        case blockType = "block_type"
    }
}

// MARK: - Title
struct Title: Codable {
    let value: String
}

// MARK: - Topic
struct Topic: Codable, SearchResult {
    let title, type: String
}
