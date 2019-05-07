import Foundation
import UIKit

class CartCoordinator: Coordinator {
    let navigationCoordination: NavigationCoordination
    private let cartViewController: CartViewController
    
    init(navigationCoordination: NavigationCoordination,
         cartViewController: CartViewController) {
        self.navigationCoordination = navigationCoordination
        self.cartViewController = cartViewController
    }
    
    func start() {
        self.navigationCoordination.navigationController.viewControllers = [self.cartViewController]
//        self.navigationCoordination.setStack([self.cartViewController])
    }
}
