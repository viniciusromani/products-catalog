import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    
    private let window: UIWindow
    private let navigationCoordination: NavigationCoordination
    private let tabController: TabController
    
    init(window: UIWindow,
         navigationCoordination: NavigationCoordination,
         tabController: TabController) {
        self.window = window
        self.navigationCoordination = navigationCoordination
        self.tabController = tabController
    }
    
    func start() {
        self.navigationCoordination.setStack([self.tabController])
        self.window.rootViewController = self.navigationCoordination.navigationController
        self.window.makeKeyAndVisible()
    }
}
