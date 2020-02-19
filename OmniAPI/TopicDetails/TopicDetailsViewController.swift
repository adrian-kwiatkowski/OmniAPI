import UIKit

class TopicDetailsViewController: UIViewController {
    
    private let viewModel: TopicDetailsViewModel
    private let mainView: TopicDetailsView
    
    init(viewModel: TopicDetailsViewModel) {
        self.viewModel = viewModel
        mainView = TopicDetailsView()
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}
