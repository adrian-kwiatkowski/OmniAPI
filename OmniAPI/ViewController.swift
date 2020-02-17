import UIKit

class ViewController: UIViewController {
    
    let tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        fetchData()
    }
}

// MARK: - Networking
extension ViewController {
    
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
