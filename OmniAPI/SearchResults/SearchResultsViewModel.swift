import RxSwift
import RxCocoa
import PromiseKit

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
    
    func getSearchResults(for query: String) {
        fetchResults(query)
            .done {
                self.topics.accept($0.topics)
                self.articles.accept($0.articles)
                switch self.contentType.value {
                case .articles:
                    self.searchResults.accept(self.articles.value)
                case .topics:
                    self.searchResults.accept(self.topics.value)
                }
        }
        .catch { error in
            // TODO: - delegate with display alert on ViewController here
            print(error.localizedDescription)
        }
    }
}

// MARK: - Networking
extension SearchResultsViewModel {
    
    enum NetworkError: Error {
        case invalidURL
    }
    
    func fetchResults(_ query: String) -> Promise<Welcome> {
        let escapedString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        // https://omni-content.omni.news/search?query=stockholm
        var components = URLComponents()
        components.scheme = "https"
        components.host = "omni-content.omni.news"
        components.path = "/search"
        components.queryItems = [
            URLQueryItem(name: "query", value: escapedString),
        ]
        
        guard let url = components.url else { return Promise(error: NetworkError.invalidURL) }
        
        return firstly {
            URLSession.shared.dataTask(.promise, with: url)
        }.compactMap {
            return try JSONDecoder().decode(Welcome.self, from: $0.data)
        }
    }
}


