import UIKit

class TopicCell: UITableViewCell {
    
    // MARK: - INIT
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupUI() {
        detailTextLabel?.textColor = .lightGray
    }
    
    // MARK: - PUBLIC METHODS
    
    func configure(with topic: Topic) {
        textLabel?.text = topic.title
        detailTextLabel?.text = topic.type.capitalized
    }
}
