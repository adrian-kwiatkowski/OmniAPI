import UIKit

class TopicDetailsViewController: UIViewController {
    
    private let viewModel: TopicDetailsViewModel
    
    init(viewModel: TopicDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
