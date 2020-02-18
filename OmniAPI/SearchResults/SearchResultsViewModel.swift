import UIKit
import RxSwift
import RxCocoa

struct SearchResultsViewModel {
    
    enum ContentType: Int {
        case articles = 0
        case topics = 1
    }
    
    // MARK: - PRIVATE PROPERTIES
    
    private let contentType = BehaviorRelay<ContentType>(value: .articles)
    private let topics = BehaviorRelay<[Topic]>(value: [])
    private let articles = BehaviorRelay<[Article]>(value: [])
    private let disposeBag = DisposeBag()
    
    // MARK: - PUBLIC PROPERTIES
    
    let searchResults = BehaviorRelay<[SearchResult]>(value: [])
    
    // MARK: - INIT
    
    init() {
        bindData()
    }
    
    // MARK: - PRIVATE METHODS
    
    private func bindData() {
        contentType.subscribe(onNext: {
            switch $0 {
            case .articles:
                self.searchResults.accept(self.articles.value)
            case .topics:
                self.searchResults.accept(self.topics.value)
            }
        }).disposed(by: disposeBag)
    }
    
    // MARK: - PUBLIC METHODS
    
    func changeContentType(_ newContentType: ContentType) {
        contentType.accept(newContentType)
    }
    
    func getSearchResults(_ query: String) {
        let escapedString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        // https://omni-content.omni.news/search?query=stockholm
        var components = URLComponents()
        components.scheme = "https"
        components.host = "omni-content.omni.news"
        components.path = "/search"
        components.queryItems = [
            URLQueryItem(name: "query", value: escapedString),
        ]

        guard let url = components.url else { return }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let welcome = try JSONDecoder().decode(Welcome.self, from: data)
                        self.topics.accept(welcome.topics)
                        self.articles.accept(welcome.articles)
                        switch self.contentType.value {
                        case .articles:
                            self.searchResults.accept(self.articles.value)
                        case .topics:
                            self.searchResults.accept(self.topics.value)
                        }
                    } catch {
                        // TODO: - delegate with display alert on ViewController here
                        print(error.localizedDescription)
                    }
                } else {
                    // TODO: - delegate with display alert on ViewController here
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
        task.resume()
    }
}
