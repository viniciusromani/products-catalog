import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    let navigationCoordination: NavigationCoordination
    private let homeViewController: HomeViewController
    
    init(navigationCoordination: NavigationCoordination,
         homeViewController: HomeViewController) {
        self.navigationCoordination = navigationCoordination
        self.homeViewController = homeViewController
    }
    
    func start() {
        self.navigationCoordination.navigationController.viewControllers = [self.homeViewController]
//        self.navigationCoordination.setStack([self.homeViewController])
    }
}
