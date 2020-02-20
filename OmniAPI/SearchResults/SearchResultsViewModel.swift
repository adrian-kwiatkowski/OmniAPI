import RxSwift
import RxCocoa

struct SearchResultsViewModel {
    
    enum ContentType: Int {
        case articles = 0
        case topics = 1
    }
    
    // MARK: - PRIVATE PROPERTIES
    
    private let networkService: NetworkService
    
    private let contentType = BehaviorRelay<ContentType>(value: .articles)
    private let topics = BehaviorRelay<[Topic]>(value: [])
    private let articles = BehaviorRelay<[Article]>(value: [])
    private let disposeBag = DisposeBag()
    
    // MARK: - PUBLIC PROPERTIES
    
    let searchResults = BehaviorRelay<[SearchResult]>(value: [])
    let errorDescription = BehaviorRelay<String>(value: String())
    
    // MARK: - INIT
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
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
        networkService.fetchResults(query)
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
            self.errorDescription.accept(error.localizedDescription)
        }
    }
}
