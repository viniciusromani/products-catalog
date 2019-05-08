import UIKit

extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach(addSubview)
    }
    
    var iPhoneXHackInset: CGFloat {
        if #available(iOS 11, *) {
            let safeAreaInset = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
            return safeAreaInset > 20 ? 50: safeAreaInset
        }
        return 20
    }
}
