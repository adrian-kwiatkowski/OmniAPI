import UIKit

class ArticleDetailsViewController: UIViewController {
    
    // MARK: - PRIVATE PROPERTIES
    
    private let viewModel: ArticleDetailsViewModel
    private let mainView: ArticleDetailsView
    
    // MARK: - INIT
    
    init(viewModel: ArticleDetailsViewModel) {
        self.viewModel = viewModel
        mainView = ArticleDetailsView()
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}
