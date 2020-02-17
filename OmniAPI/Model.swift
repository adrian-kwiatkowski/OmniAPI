// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let articles: [Article]
    let topics: [Topic]
}

// MARK: - Article
struct Article: Codable {
    let articleID: String
    let title: TitleClass
    let authors: [Author]
    let resources: [Resource]
    let meta: Meta
    let tags: [Topic]
    let type: ArticleType
    let changes: ArticleChanges
    let mainText: MainText
    let mainResource: MainResource
    let storyVignette: StoryVignette
    let story: Topic?

    enum CodingKeys: String, CodingKey {
        case articleID = "article_id"
        case title, authors, resources, meta, tags, type, changes
        case mainText = "main_text"
        case mainResource = "main_resource"
        case storyVignette = "story_vignette"
        case story
    }
}

// MARK: - Author
struct Author: Codable {
    let id, title: String
}

// MARK: - Color
struct Color: Codable {
    let red, green, blue: Int
}

// MARK: - Icon
struct Icon: Codable {
    let imageURL: String
    let color: Color

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case color
    }
}

enum Slug: String, Codable {
    case inrikes = "inrikes"
    case nojekultur = "nojekultur"
    case opinion = "opinion"
}

enum TitleEnum: String, Codable {
    case inrikes = "Inrikes"
    case nöjeKultur = "Nöje & kultur"
    case opinion = "Opinion"
}

// MARK: - ArticleChanges
struct ArticleChanges: Codable {
    let published, modified: String
    let updated: String?
}

// MARK: - MainResource
struct MainResource: Codable {
    let type: MainResourceType
    let byline: Byline
    let caption: TitleClass?
    let sourceID: String?
    let imageAsset: ImageAsset
    let characteristics: Characteristics?

    enum CodingKeys: String, CodingKey {
        case type, byline, caption
        case sourceID = "source_id"
        case imageAsset = "image_asset"
        case characteristics
    }
}

// MARK: - Byline
struct Byline: Codable {
    let title: String
}

// MARK: - TitleClass
struct TitleClass: Codable {
    let value: String
}

// MARK: - Characteristics
struct Characteristics: Codable {
    let figure, sensitive: Bool
}

// MARK: - ImageAsset
struct ImageAsset: Codable {
    let id: String
    let size: Size
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
}

enum MainResourceType: String, Codable {
    case byline = "Byline"
    case carousel = "Carousel"
    case image = "Image"
    case storyVignette = "StoryVignette"
    case subheading = "Subheading"
    case text = "Text"
    case title = "Title"
    case url = "Url"
    case webview = "Webview"
}

// MARK: - MainText
struct MainText: Codable {
    let type: MainResourceType
    let paragraphs: [Paragraph]
    let vignette: MainTextVignette
}

// MARK: - Paragraph
struct Paragraph: Codable {
    let text: Text
    let blockType: BlockType

    enum CodingKeys: String, CodingKey {
        case text
        case blockType = "block_type"
    }
}

enum BlockType: String, Codable {
    case paragraph = "paragraph"
}

// MARK: - Text
struct Text: Codable {
    let value: String
    let markup: [Markup]?
}

// MARK: - Markup
struct Markup: Codable {
    let type: MarkupType
    let length, offset: Int
}

enum MarkupType: String, Codable {
    case styleStrong = "style:strong"
}

// MARK: - MainTextVignette
struct MainTextVignette: Codable {
    let title: String
    let bulletColor: Color
    let supertag: Supertag?

    enum CodingKeys: String, CodingKey {
        case title
        case bulletColor = "bullet_color"
        case supertag
    }
}

// MARK: - Supertag
struct Supertag: Codable {
    let topicID, title, text: String

    enum CodingKeys: String, CodingKey {
        case topicID = "topic_id"
        case title, text
    }
}

// MARK: - Meta
struct Meta: Codable {
    let changes: MetaChanges
    let version: Int
    let isSticky: Bool
    let newsvalue: Int
    let isDeleted, isSponsored: Bool
    let machineTags: MachineTags
    let newsLifetime: Int
    let customProperties: MetaCustomProperties

    enum CodingKeys: String, CodingKey {
        case changes, version
        case isSticky = "is_sticky"
        case newsvalue
        case isDeleted = "is_deleted"
        case isSponsored = "is_sponsored"
        case machineTags = "machine_tags"
        case newsLifetime = "news_lifetime"
        case customProperties = "custom_properties"
    }
}

// MARK: - MetaChanges
struct MetaChanges: Codable {
    let bumped: JSONNull?
    let created, updated, published: String
    let bumpedValue: Bool
    let firstPublished: String

    enum CodingKeys: String, CodingKey {
        case bumped, created, updated, published
        case bumpedValue = "bumped_value"
        case firstPublished = "first_published"
    }
}

// MARK: - MetaCustomProperties
struct MetaCustomProperties: Codable {
    let bump: Bool
    let sticky: String
    let longread: Bool
}

// MARK: - MachineTags
struct MachineTags: Codable {
    let gender: String
}

// MARK: - Resource
struct Resource: Codable {
    let type: MainResourceType
    let byline: Byline?
    let caption: TitleClass?
    let sourceID: String?
    let imageAsset: ImageAsset?
    let ref: Ref?
    let id: String?
    let title: TitleUnion?
    let text: TitleClass?
    let published: String?
    let authors: [Author]?
    let fallbackEmail: FallbackEmail?
    let paragraphs: [Paragraph]?
    let vignette: ResourceVignette?
    let url: String?
    let data: DataClass?
    let source, label: String?
    let height: Int?
    let supertag: Supertag?
    let topic: Topic?
    let characteristics: Characteristics?
    let updated: String?

    enum CodingKeys: String, CodingKey {
        case type, byline, caption
        case sourceID = "source_id"
        case imageAsset = "image_asset"
        case ref, id, title, text, published, authors
        case fallbackEmail = "fallback_email"
        case paragraphs, vignette, url, data, source, label, height, supertag, topic, characteristics, updated
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let canonicalURL: String
    let type, source: String?
    let customProperties: DataCustomProperties?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case canonicalURL = "canonical_url"
        case type, source
        case customProperties = "custom_properties"
        case image
    }
}

// MARK: - DataCustomProperties
struct DataCustomProperties: Codable {
    let text, title, schema, pageID: String?
    let thumbnail: String?
    let customPropertiesDescription: String?
    let thumbnailURL: String?
    let user: User?
    let created, tweetID: String?

    enum CodingKeys: String, CodingKey {
        case text, title, schema
        case pageID = "page_id"
        case thumbnail
        case customPropertiesDescription = "description"
        case thumbnailURL = "thumbnail_url"
        case user, created
        case tweetID = "tweet_id"
    }
}

// MARK: - User
struct User: Codable {
    let title: String
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case title
        case avatarURL = "avatar_url"
    }
}

enum FallbackEmail: String, Codable {
    case redaktionOmniSE = "redaktion@omni.se"
}

enum Ref: String, Codable {
    case category = "category"
    case story = "story"
}

enum TitleUnion: Codable {
    case string(String)
    case titleClass(TitleClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(TitleClass.self) {
            self = .titleClass(x)
            return
        }
        throw DecodingError.typeMismatch(TitleUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TitleUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .titleClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Topic
struct Topic: Codable {
    let type: TopicType
    let title, topicID: String
    let image: MainResource?

    enum CodingKeys: String, CodingKey {
        case type, title
        case topicID = "topic_id"
        case image
    }
}

enum TopicType: String, Codable {
    case descriptor = "descriptor"
    case location = "location"
    case organization = "organization"
    case person = "person"
    case story = "story"
}

// MARK: - ResourceVignette
struct ResourceVignette: Codable {
    let title: String
    let bulletColor: Color

    enum CodingKeys: String, CodingKey {
        case title
        case bulletColor = "bullet_color"
    }
}

// MARK: - StoryVignette
struct StoryVignette: Codable {
    let ref: Ref
    let id, title: String
    let supertag: Supertag?
}

enum ArticleType: String, Codable {
    case article = "Article"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
