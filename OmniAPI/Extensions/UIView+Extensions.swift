import UIKit
import AsyncDisplayKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        _ = views.map { addSubview($0) }
    }
}
