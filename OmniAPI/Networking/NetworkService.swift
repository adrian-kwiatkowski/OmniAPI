import Foundation
import PromiseKit

struct NetworkService {
    
    enum NetworkError: Error {
        case invalidURL
    }
    
    func fetchResults(_ query: String) -> Promise<Welcome> {
        let escapedString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
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
