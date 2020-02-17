import Foundation

struct Welcome: Codable {
    let articles: [Article]
    let topics: [Topic]
}

struct Article: Codable {
    let title: String
}

struct Topic: Codable {
    let title: String
}
