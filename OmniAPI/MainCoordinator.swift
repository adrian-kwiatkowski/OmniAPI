import UIKit

class MainCoordinator: Coordinator {
    internal var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = SearchResultsViewController(coordinator: self)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func searchResultDetails(_ searchResult: SearchResult) {
        print("\(searchResult)")
    }
}
