import UIKit
import AsyncDisplayKit

class TopicDetailsView: UIView {
    
    // MARK: - UI PROPERTIES
    
    let primaryTextNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 3
        return node
    }()
    
    let secondaryTextNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 2
        return node
    }()
    
    // MARK: - INIT
    
    init(primaryText: String, secondaryText: String) {
        super.init(frame: .zero)
        setupUI()
        primaryTextNode.attributedText = NSAttributedString(string: primaryText)
        secondaryTextNode.attributedText = NSAttributedString(string: secondaryText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE METHODS
    
    private func setupUI() {
        setupConstraints()
    }
    
    private func setupConstraints() {
        
    }
}
