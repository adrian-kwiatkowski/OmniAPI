import UIKit
import RxSwift
import RxCocoa

struct SearchResultsViewModel {
    
    let topics = BehaviorRelay<[Topic]>(value: [])
    let articles = BehaviorRelay<[Article]>(value: [])
    
    init() {
        getSearchResults("stockholm")
    }
    
    func getSearchResults(_ query: String) {
        guard let url = URL(string: "https://omni-content.omni.news/search?query=\(query)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let welcome = try JSONDecoder().decode(Welcome.self, from: data)
                        self.topics.accept(welcome.topics)
                        self.articles.accept(welcome.articles)
                    } catch {
                        print(error.localizedDescription)
                        print(response)
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
