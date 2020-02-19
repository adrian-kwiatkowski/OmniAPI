import UIKit

class ArticleDetailsViewController: UIViewController {
    
    // MARK: - PRIVATE PROPERTIES
    
    private let viewModel: ArticleDetailsViewModel
    private let mainView: ArticleDetailsView
    
    // MARK: - INIT
    
    init(viewModel: ArticleDetailsViewModel) {
        self.viewModel = viewModel
        mainView = ArticleDetailsView(titleText: viewModel.titleText, imageURL: viewModel.imageURL, bodyText: viewModel.bodyText)
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
