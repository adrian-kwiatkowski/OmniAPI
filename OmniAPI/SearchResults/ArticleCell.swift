import UIKit
import SnapKit
import AsyncDisplayKit

class ArticleCell: UITableViewCell {
    
    // MARK: - UI PROPERTIES
    
    private let mainImageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.defaultImage = UIImage(named: "placeholderImage")
        node.placeholderEnabled = true
        node.cornerRadius = 12.0
        return node
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 3
        view.textAlignment = .center
        return view
    }()
    
    // MARK: - INIT
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupUI() {
        addSubnode(mainImageNode)
        addSubview(titleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        mainImageNode.view.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().offset(-20.0)
            $0.height.equalTo(160.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(mainImageNode.view.snp.bottom).offset(15.0)
            $0.bottom.equalToSuperview().offset(-20.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().offset(-20.0)
        }
    }
    
    // MARK: - PUBLIC METHODS
    
    func configure(with article: Article) {
        mainImageNode.url = article.imageURL
        titleLabel.text = article.title.value
    }
}
