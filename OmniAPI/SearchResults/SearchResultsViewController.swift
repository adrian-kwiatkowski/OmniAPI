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
        title = "Omni API"
        view.backgroundColor = .white
        view.addSubview(mainView)
        
        mainView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    private func bindUI() {
        mainView.segmentedControl.rx.selectedSegmentIndex.subscribe(onNext: { index in
            guard let contentType = SearchResultsViewModel.ContentType.init(rawValue: index) else { return }
            self.viewModel.changeContentType(contentType)
        }).disposed(by: disposeBag)
        
        mainView.tableView.rx.modelSelected(SearchResult.self)
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
                    self.viewModel.getSearchResults(for: $0)
                }
            }).disposed(by: disposeBag)
        
        viewModel.searchResults.bind(to: mainView.tableView.rx.items(cellIdentifier: "SearchResultCell", cellType: SearchResultCell.self)) { (row, element, cell) in
            if let article = element as? Article {
                cell.textLabel?.text = article.title.value
            } else if let topic = element as? Topic {
                cell.textLabel?.text = topic.title
            }
        }.disposed(by: disposeBag)
    }
}
