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
        
        mainView.tableView.rx.itemSelected
            .subscribe(onNext:  { value in
                print("Tapped cell: \(value)")
            })
            .disposed(by: disposeBag)
        
        mainView.searchBar.rx.text.orEmpty
            .asDriver()
            .throttle(.milliseconds(300))
            .distinctUntilChanged()
            .drive(onNext: {
                if $0.count >= 3 {
                    self.viewModel.getSearchResults($0)
                }
            }).disposed(by: disposeBag)
        
    }
    
    private func showArticles() {
        viewModel.articles.bind(to: mainView.tableView.rx.items(cellIdentifier: "ArticleCell", cellType: ArticleCell.self)) { (row, article, cell) in
            cell.textLabel?.text = article.title.value
        }.disposed(by: disposeBag)
    }
    
    private func showTopics() {
        viewModel.topics.bind(to: mainView.tableView.rx.items(cellIdentifier: "TopicCell", cellType: TopicCell.self)) { (row, topic, cell) in
            cell.textLabel?.text = topic.title
        }.disposed(by: disposeBag)
    }
}
