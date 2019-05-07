import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    
    private let window: UIWindow
    private let tabController: TabController
    
    init(window: UIWindow,
         tabController: TabController) {
        self.window = window
        self.tabController = tabController
    }
    
    func start() {
        self.window.rootViewController = self.tabController
        self.window.makeKeyAndVisible()
    }
}
