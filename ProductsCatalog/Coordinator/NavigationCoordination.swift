import UIKit

class NavigationCoordination {
    
    private let animate = true
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func setStack(_ newStack: [UIViewController]) {
        var animated = self.animate
        if self.navigationController.presentedViewController != nil {
            animated = false
        }
        self.navigationController.setViewControllers(newStack, animated: animated)
    }
    
    func presentModally(viewController next: UIViewController,
                        onViewController top: UIViewController? = nil,
                        completion: (() -> Void)? = nil) {
        let root = top ?? self.topViewController()
        root?.present(next, animated: self.animate, completion: completion)
    }
    
    func dismissModal(onViewController top: UIViewController? = nil, completion: (() -> Void)? = nil) {
        let root = top ?? self.topViewController()
        root?.dismiss(animated: self.animate, completion: completion)
    }
    
    func push(viewController next: UIViewController) {
        self.navigationController.pushViewController(next, animated: self.animate)
    }
    
    func pop() {
        self.navigationController.popViewController(animated: self.animate)
    }
}

extension NavigationCoordination {
    func topViewController() -> UIViewController? {
        var topViewController: UIViewController = self.navigationController
        
        while let newTop = topViewController.presentedViewController {
            topViewController = newTop
        }
        
        return topViewController
    }
}
