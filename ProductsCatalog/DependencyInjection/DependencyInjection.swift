import FirebaseDatabase
import Moya
import Swinject

class DependencyInjection {
    
    private static let container = Container()
    
    static func configure() -> Container {
        self.injectCoordinators(on: self.container)
        self.injectNetworkProvider(on: self.container)
        self.injectRemoteDatabase(on: self.container)
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
        }.inObjectScope(.transient)
        
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
    
    private static func injectRemoteDatabase(on container: Container) {
        container.register(DatabaseReference.self) { _ in
            return Database.database().reference()
        }
    }
    
    private static func injectDataSource(on container: Container) {
        container.register(ProductsDataSource.self) { resolver in
            return ApiProductsDataSource(provider: resolver.resolve(MoyaProvider<Endpoint>.self)!)
        }
        
        container.register(RemoteDatabaseDataSource.self) { resolver in
            return FirebaseRemoteDatabaseDataSource()
        }
    }

    private static func injectRepository(on container: Container) {
        container.register(ProductsRepository.self) { resolver in
            return ProductsRepository(dataSource: resolver.resolve(ProductsDataSource.self)!)
        }
        
        container.register(RemoteDatabaseRepository.self) { resolver in
            return RemoteDatabaseRepository(dataSource: resolver.resolve(RemoteDatabaseDataSource.self)!)
        }
    }
    
    private static func injectUseCase(on container: Container) {
        container.register(RetrieveProductsUseCase.self) { resolver in
            return RetrieveProductsUseCase(repository: resolver.resolve(ProductsRepository.self)!)
        }
        
        container.register(AddProductToCartUseCase.self) { resolver in
            return AddProductToCartUseCase(repository: resolver.resolve(RemoteDatabaseRepository.self)!)
        }
        
        container.register(RemoveProductFromCartUseCase.self) { resolver in
            return RemoveProductFromCartUseCase(repository: resolver.resolve(RemoteDatabaseRepository.self)!)
        }
        
        container.register(RetrieveCartProductsUseCase.self) { resolver in
            return RetrieveCartProductsUseCase(repository: resolver.resolve(RemoteDatabaseRepository.self)!)
        }
        
        container.register(RetrieveAvailableSizesUseCase.self) { resolver in
            return RetrieveAvailableSizesUseCase()
        }
        
        container.register(CalculateTotalCartPriceUseCase.self) { resolver in
            return CalculateTotalCartPriceUseCase()
        }
    }
    
    private static func injectPresenter(on container: Container) {
        container.register(HomePresenter.self) { resolver in
            return HomePresenter(retrieveProductsUseCase: resolver.resolve(RetrieveProductsUseCase.self)!,
                                 retrieveAvailableSizesUseCase: resolver.resolve(RetrieveAvailableSizesUseCase.self)!,
                                 addProductToCartUseCase: resolver.resolve(AddProductToCartUseCase.self)!)
        }
        
        container.register(CartPresenter.self) { resolver in
            return CartPresenter(retrieveCartProductsUseCase: resolver.resolve(RetrieveCartProductsUseCase.self)!,
                                 removeProductFromCartUseCase: resolver.resolve(RemoveProductFromCartUseCase.self)!,
                                 calculateTotalCartPriceUseCase: resolver.resolve(CalculateTotalCartPriceUseCase.self)!)
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
