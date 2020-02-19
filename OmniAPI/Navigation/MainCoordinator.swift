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
        if let topic = searchResult as? Topic {
            let viewModel = TopicDetailsViewModel(topic)
            let viewController = TopicDetailsViewController(viewModel: viewModel)
            navigationController.pushViewController(viewController, animated: true)
        } else if let article = searchResult as? Article {
            let viewModel = ArticleDetailsViewModel(article)
            let viewController = ArticleDetailsViewController(viewModel: viewModel)
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
