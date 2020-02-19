import UIKit

class TopicDetailsViewController: UIViewController {
    
    // MARK: - PRIVATE PROPERTIES
    
    private let viewModel: TopicDetailsViewModel
    private let mainView: TopicDetailsView
    
    // MARK: - INIT
    
    init(viewModel: TopicDetailsViewModel) {
        self.viewModel = viewModel
        mainView = TopicDetailsView(primaryText: viewModel.primaryText, secondaryText: viewModel.secondaryText)
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubnode(mainView)
        
        mainView.view.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
