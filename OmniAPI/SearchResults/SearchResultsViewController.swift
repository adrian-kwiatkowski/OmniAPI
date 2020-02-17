import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SearchResultsViewController: UIViewController {
    
    // MARK: - PRIVATE PROPERTIES
    
    private let mainView: SearchResultsView
    private let viewModel: SearchResultsViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - INIT
    
    init(viewModel: SearchResultsViewModel = SearchResultsViewModel()) {
        self.viewModel = viewModel
        self.mainView = SearchResultsView()
        super.init(nibName: nil, bundle: nil)
        setupUI()
        bindUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(mainView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        mainView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    private func bindUI() {
        viewModel.articles.bind(to: mainView.tableView.rx.items(cellIdentifier: "ArticleCell", cellType: ArticleCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "article: \(element.title.value)"
            
        }.disposed(by: disposeBag)
        
    }
}
