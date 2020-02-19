import UIKit

class ArticleDetailsViewController: UIViewController {
    
    private let viewModel: ArticleDetailsViewModel
    
    init(viewModel: ArticleDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
