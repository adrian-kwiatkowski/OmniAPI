import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    
    func start()
    func searchResultDetails(_ searchResult: SearchResult)
}
