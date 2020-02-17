import UIKit
import SnapKit

class SearchResultsViewController: UIViewController {
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        return view
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    // MARK: - INIT
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupUI()
        configureDataSource()
        fetchData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupUI() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func configureDataSource() {
        tableView.register(ArticleCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.register(TopicCell.self, forCellReuseIdentifier: "TopicCell")
    }
}

// MARK: - Networking
extension SearchResultsViewController {
    
    func fetchData() {
        guard let url = URL(string: "https://omni-content.omni.news/search?query=stockholm") else { return }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let welcome = try JSONDecoder().decode(Welcome.self, from: data)
                        print(welcome.articles.count, welcome.topics.count)
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    // TODO: - display native ios alert here
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
        task.resume()
    }
}
