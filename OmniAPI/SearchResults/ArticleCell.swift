import UIKit
import SnapKit

class ArticleCell: UITableViewCell {
    
    // MARK: - UI PROPERTIES
    
    private let mainImageView: UIImageView = {
        let view = UIImageView()
        return view
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
        addSubview(mainImageView)
        addSubview(titleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        mainImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().offset(-20.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(15.0)
            $0.bottom.equalToSuperview().offset(-20.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.trailing.equalToSuperview().offset(-20.0)
        }
    }
    
    // MARK: - PUBLIC METHODS
    
    func configure(with article: Article) {
        mainImageView.image = UIImage(named: "test")
        titleLabel.text = article.title.value
    }
}
