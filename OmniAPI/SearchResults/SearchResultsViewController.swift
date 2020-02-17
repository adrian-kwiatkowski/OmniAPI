import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SearchResultsViewController: UIViewController {
    
    // MARK: - PRIVATE PROPERTIES
    
    private let mainView: SearchResultsView
    private let viewModel: SearchResultsViewModel
    private let disposeBag = DisposeBag()
    
    private enum Content: Int {
        case articles = 0
        case topics = 1
    }
    
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
        title = "Omni API"
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
        mainView.segmentedControl.rx.selectedSegmentIndex.subscribe(onNext: { index in
            guard let content = Content.init(rawValue: index) else { return }
            self.mainView.tableView.dataSource = nil
            switch content {
            case .articles:
                self.showArticles()
            case .topics:
                self.showTopics()
            }
        }).disposed(by: disposeBag)
    }
    
    private func showArticles() {
        viewModel.articles.bind(to: mainView.tableView.rx.items(cellIdentifier: "ArticleCell", cellType: ArticleCell.self)) { (row, element, cell) in
            cell.textLabel?.text = element.title.value
            
        }.disposed(by: disposeBag)
    }
    
    private func showTopics() {
        viewModel.topics.bind(to: mainView.tableView.rx.items(cellIdentifier: "TopicCell", cellType: TopicCell.self)) { (row, element, cell) in
            cell.textLabel?.text = element.title
            
        }.disposed(by: disposeBag)
    }
}
