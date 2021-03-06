import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SearchResultsViewController: UIViewController {
    
    // MARK: - PRIVATE PROPERTIES
    
    private let coordinator: Coordinator
    private let mainView: SearchResultsView
    private let viewModel: SearchResultsViewModel
    private let disposeBag: DisposeBag
    
    // MARK: - INIT
    
    init(viewModel: SearchResultsViewModel = SearchResultsViewModel(), coordinator: Coordinator) {
        self.viewModel = viewModel
        self.disposeBag = viewModel.disposeBag
        self.mainView = SearchResultsView()
        self.coordinator = coordinator
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
        view.addSubnode(mainView)
        
        mainView.view.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    private func bindUI() {
        viewModel.errorDescription
            .subscribe(onNext: { [weak self] (errorDescription) in
                self?.coordinator.showError(with: errorDescription)
            }).disposed(by: disposeBag)
        
        mainView.segmentedControl.rx.selectedSegmentIndex
            .subscribe(onNext: { [weak self] index in
                guard let contentType = SearchResultsViewModel.ContentType.init(rawValue: index) else { return }
                self?.viewModel.changeContentType(contentType)
            }).disposed(by: disposeBag)
        
        mainView.tableView.rx.modelSelected(SearchResult.self)
            .subscribe(onNext: { [weak self] value in
                self?.coordinator.searchResultDetails(value)
            }).disposed(by: disposeBag)
        
        mainView.tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] (indexPath) in
                self?.mainView.tableView.deselectRow(at: indexPath, animated: true)
                self?.mainView.searchBar.resignFirstResponder()
            }).disposed(by: disposeBag)
        
        mainView.searchBar.rx.text.orEmpty
            .asDriver()
            .throttle(.milliseconds(300))
            .distinctUntilChanged()
            .drive(onNext: { [weak self] in
                if $0.count >= 3 {
                    self?.viewModel.getSearchResults(for: $0)
                }
            }).disposed(by: disposeBag)
        
        viewModel.searchResults
            .bind(to: mainView.tableView.rx.items) { (tableView, row, element) in
                let indexPath = IndexPath(row: row, section: 0)
                
                if let article = element as? Article, let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell {
                    cell.configure(with: article)
                    return cell
                } else if let topic = element as? Topic, let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as? TopicCell {
                    cell.configure(with: topic)
                    return cell
                }
                
                return UITableViewCell()
        }.disposed(by: disposeBag)
    }
}
