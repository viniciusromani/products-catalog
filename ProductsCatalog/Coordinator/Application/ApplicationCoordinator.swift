import Foundation
import UIKit

class ApplicationCoordinator: Coordinator {
    
    private let window: UIWindow
    private let navigationCoordination: NavigationCoordination
    private let cartCoordinator: CartCoordinator
    
    init(window: UIWindow,
         navigationCoordination: NavigationCoordination,
         cartCoordinator: CartCoordinator) {
        self.window = window
        self.navigationCoordination = navigationCoordination
        self.cartCoordinator = cartCoordinator
    }
    
    func start() {
        self.cartCoordinator.start()
        self.window.rootViewController = self.navigationCoordination.navigationController
        self.window.makeKeyAndVisible()
    }
}
