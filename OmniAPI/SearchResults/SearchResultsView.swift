import UIKit

class SearchResultsView: UIView {
    
    // MARK: - UI PROPERTIES
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.searchBarStyle = .minimal
        view.placeholder = "Query"
        return view
    }()
    
    let segmentedControl: UISegmentedControl = {
        let view = UISegmentedControl(items: ["Articles", "Topics"])
        view.selectedSegmentIndex = 0
        view.backgroundColor = .white
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.keyboardDismissMode = .interactive
        return view
    }()
    
    // MARK: - INIT
    
    init() {
        super.init(frame: .zero)
        setupUI()
        configureDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupUI() {
        addSubview(searchBar)
        addSubview(segmentedControl)
        addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(6.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().offset(-20.0)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(20.0)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func configureDataSource() {
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.register(TopicCell.self, forCellReuseIdentifier: "TopicCell")
    }
}
