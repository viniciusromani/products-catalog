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
        self.navigationCoordination.setStack([self.homeViewController])
        self.homeViewController.navigationItem.title = R.string.localizable.homeNavigationTitle()
    }
}
