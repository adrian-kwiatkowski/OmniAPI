import UIKit
import AsyncDisplayKit

class ArticleDetailsView: ASDisplayNode {
    
    // MARK: - UI PROPERTIES
    
    let scrollNode: ASScrollNode = {
        let node = ASScrollNode()
        node.automaticallyManagesSubnodes = true
        node.automaticallyManagesContentSize = true
        node.view.showsVerticalScrollIndicator = false
        return node
    }()
    
    let titleNode: ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    let imageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.defaultImage = UIImage(named: "placeholderImage")
        node.placeholderEnabled = true
        node.cornerRadius = 12.0
        return node
    }()
    
    let bodyNode: ASTextNode = {
        let node = ASTextNode()
        return node
    }()
    
    // MARK: - INIT
    
    init(titleText: String, imageURL: URL?, bodyText: String) {
        super.init()
        automaticallyManagesSubnodes = true
        
        titleNode.attributedText = NSAttributedString(string: titleText)
        imageNode.url = imageURL
        bodyNode.attributedText = NSAttributedString(string: bodyText)
    }
    
    // MARK: - LAYOUT
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        scrollNode.layoutSpecBlock = { node, constrainedSize in
            let stack = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 20.0,
                                          justifyContent: .start,
                                          alignItems: .stretch,
                                          children: [self.titleNode, self.imageNode, self.bodyNode])
            
          return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0), child: stack)
        }
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), child: scrollNode)
    }
}
