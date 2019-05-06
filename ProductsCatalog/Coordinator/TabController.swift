import UIKit

class TabController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTabs(tabs: [UIViewController]) {
        self.viewControllers = tabs
    }
}
