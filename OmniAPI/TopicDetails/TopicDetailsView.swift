import UIKit
import AsyncDisplayKit

class TopicDetailsView: ASDisplayNode {
    
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
    
    // MARK: - PRIVATE PROPERTIES
    
    private let primaryTextAttributes: [NSAttributedString.Key: Any] = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 31),
            .paragraphStyle: paragraphStyle
        ]
        
        return attributes
    }()
    private let secondaryTextAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor.lightGray,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 19)
    ]
    
    // MARK: - INIT
    
    init(primaryText: String, secondaryText: String) {
        super.init()
        automaticallyManagesSubnodes = true
        
        primaryTextNode.attributedText = NSMutableAttributedString(string: primaryText, attributes: primaryTextAttributes)
        secondaryTextNode.attributedText = NSAttributedString(string: secondaryText, attributes: secondaryTextAttributes)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LAYOUT
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let primaryCenteredSpec = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: primaryTextNode)
        let secondaryCenteredSpec = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: secondaryTextNode)

        let nameLocationStack = ASStackLayoutSpec.vertical()
        nameLocationStack.children = [primaryCenteredSpec, secondaryCenteredSpec]
        let headerStackSpec = ASStackLayoutSpec(direction: .vertical,
                                                spacing: 40.0,
                                                justifyContent: .center,
                                                alignItems: .center,
                                                children: [nameLocationStack])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0), child: headerStackSpec)
    }
}
