import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = SearchResultsViewController()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
}
