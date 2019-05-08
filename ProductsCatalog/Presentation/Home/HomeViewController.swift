import UIKit

protocol HomeViewProtocol: class {
    func productsFetched(with viewModel: [ProductViewModel])
    func errorGettingProducts()
    
    func askUserAboutAddToCart(with viewModel: AlertToCartViewModel)
}

class HomeViewController: UIViewController {
    
    var homeView: HomeView!
    var presenter: HomePresenter
    lazy var dataSource = ProductsCollectionViewDataSource(collection: self.homeView.collection,
                                                           delegate: self)
    
    init(presenter: HomePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.homeView = HomeView()
        self.view = self.homeView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.homeView.displayLoading()
        self.presenter.retrieveProducts()
    }
}

extension HomeViewController: HomeViewProtocol {
    func productsFetched(with viewModel: [ProductViewModel]) {
        self.homeView.removeLoading()
        self.dataSource.setProducts(with: viewModel)
    }
    
    func errorGettingProducts() {
        print("error")
    }
    
    func askUserAboutAddToCart(with viewModel: AlertToCartViewModel) {
        print(viewModel)
    }
}

extension HomeViewController: ProductsCollectionViewDataSourceDelegate {
    func didSelect(product: ProductViewModel) {
        self.presenter.userSelected(product: product)
    }
}
