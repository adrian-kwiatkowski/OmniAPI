import UIKit

struct ArticleDetailsViewModel {
    
    // MARK: - PUBLIC PROPERTIES
    
    var titleText: String {
        article.title.value
    }
    
    var imageURL: URL? {
         article.imageURL
    }
    
    var bodyText: String {
        article.mainText.paragraphs.map {
            $0.text.value
        }.joined(separator: "\n\n")
    }
    
    // MARK: - PRIVATE PROPERTIES
    
    private let article: Article
    
    // MARK: - INIT
    
    init(_ article: Article) {
        self.article = article
    }
}
