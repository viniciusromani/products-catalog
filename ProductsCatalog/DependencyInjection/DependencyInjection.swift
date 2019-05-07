import Swinject
import Moya

class DependencyInjection {
    
    private static let container = Container()
    
    static func configure() -> Container {
        self.injectCoordinators(on: self.container)
        self.injectNetworkProvider(on: self.container)
        self.injectDataSource(on: self.container)
        self.injectRepository(on: self.container)
        self.injectUseCase(on: self.container)
        self.injectPresenter(on: self.container)
        self.injectScene(on: self.container)
        return self.container
    }
}

extension DependencyInjection {
    private static func injectCoordinators(on container: Container) {
        container.register(UIWindow.self) { _ in
            return UIWindow(frame: UIScreen.main.bounds)
        }
        
        container.register(TabController.self) { resolver in
            let tabController = TabController(homeCoordinator: resolver.resolve(HomeCoordinator.self)!,
                                              cartCoordinator: resolver.resolve(CartCoordinator.self)!)
            tabController.tabBar.tintColor = R.color.actionColor()
            return tabController
        }
        
        container.register(UINavigationController.self) { _ in
            let navigationController = UINavigationController()
            navigationController.navigationBar.barStyle = .default
            let titleAttributes = [NSAttributedString.Key.foregroundColor: R.color.actionColor()]
            navigationController.navigationBar.titleTextAttributes = titleAttributes as [NSAttributedString.Key : Any]
            return navigationController
        }
        
        container.register(NavigationCoordination.self) { resolver in
            return NavigationCoordination(navigationController: resolver.resolve(UINavigationController.self)!)
        }.inObjectScope(.transient)
        
        container.register(ApplicationCoordinator.self) { resolver in
            return ApplicationCoordinator(window: resolver.resolve(UIWindow.self)!,
                                          tabController: resolver.resolve(TabController.self)!)
        }
        
        container.register(HomeCoordinator.self) { resolver in
            return HomeCoordinator(navigationCoordination: resolver.resolve(NavigationCoordination.self)!,
                                   homeViewController: resolver.resolve(HomeViewController.self)!)
        }
        
        container.register(CartCoordinator.self) { resolver in
            return CartCoordinator(navigationCoordination: resolver.resolve(NavigationCoordination.self)!,
                                   cartViewController: resolver.resolve(CartViewController.self)!)
        }
    }
    
    private static func injectNetworkProvider(on container: Container) {
        container.register(MoyaProvider<Endpoint>.self) { _ in
            return MoyaProvider<Endpoint>()
        }
    }
    
    private static func injectDataSource(on container: Container) {
        container.register(ProductsDataSource.self) { resolver in
            return ApiProductsDataSource(provider: resolver.resolve(MoyaProvider<Endpoint>.self)!)
        }
    }

    private static func injectRepository(on container: Container) {
        container.register(ProductsRepository.self) { resolver in
            return ProductsRepository(dataSource: resolver.resolve(ProductsDataSource.self)!)
        }
    }
    
    private static func injectUseCase(on container: Container) {
        container.register(RetrieveProductsUseCase.self) { resolver in
            return RetrieveProductsUseCase(repository: resolver.resolve(ProductsRepository.self)!)
        }
    }
    
    private static func injectPresenter(on container: Container) {
        container.register(HomePresenter.self) { resolver in
            return HomePresenter(retrieveProductsUseCase: resolver.resolve(RetrieveProductsUseCase.self)!)
        }
        
        container.register(CartPresenter.self) { _ in
            return CartPresenter()
        }
    }
    
    private static func injectScene(on container: Container) {
        container.register(HomeViewController.self) { resolver in
            let presenter = resolver.resolve(HomePresenter.self)!
            let viewController = HomeViewController(presenter: presenter)
            viewController.tabBarItem = UITabBarItem(title: nil,
                                                     image: R.image.icSearch(),
                                                     selectedImage: R.image.icSearchSelected())
            viewController.presenter.view = viewController
            return viewController
        }
        
        container.register(CartViewController.self) { resolver in
            let presenter = resolver.resolve(CartPresenter.self)!
            let viewController = CartViewController(presenter: presenter)
            viewController.tabBarItem = UITabBarItem(title: nil,
                                                     image: R.image.icCart(),
                                                     selectedImage: R.image.icCartSelected())
            viewController.presenter.view = viewController
            return viewController
        }
    }
}
