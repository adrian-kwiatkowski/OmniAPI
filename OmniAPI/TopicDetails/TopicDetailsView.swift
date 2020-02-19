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
    
    // MARK: - INIT
    
    init(primaryText: String, secondaryText: String) {
        super.init()
        automaticallyManagesSubnodes = true
        
        primaryTextNode.attributedText = NSAttributedString(string: primaryText, attributes: [.font: UIFont.systemFont(ofSize: 31)])
        secondaryTextNode.attributedText = NSAttributedString(string: secondaryText, attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont.systemFont(ofSize: 19)])
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
