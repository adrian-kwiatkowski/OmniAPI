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
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc private func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = convert(keyboardScreenEndFrame, from: window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            tableView.contentInset = .zero
        } else {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - safeAreaInsets.bottom, right: 0)
        }

        tableView.scrollIndicatorInsets = tableView.contentInset
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
            $0.top.equalTo(segmentedControl.snp.bottom).offset(10.0)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func configureDataSource() {
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.register(TopicCell.self, forCellReuseIdentifier: "TopicCell")
    }
}
