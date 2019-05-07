import UIKit

class TabController: UITabBarController {
    private let homeCoordinator: HomeCoordinator
    private let cartCoordinator: CartCoordinator
    
    init(homeCoordinator: HomeCoordinator,
         cartCoordinator: CartCoordinator) {
        self.homeCoordinator = homeCoordinator
        self.cartCoordinator = cartCoordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [self.homeCoordinator.navigationCoordination.navigationController,
                                self.cartCoordinator.navigationCoordination.navigationController]
    }
}
