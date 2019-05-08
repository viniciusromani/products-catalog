import UIKit

protocol HomeViewProtocol: class {
    func productsFetched(with viewModel: [ProductViewModel])
    func errorGettingProducts()
    
    func askUserAboutAddToCart(with viewModel: AlertToCartViewModel)
    func productWasAdded()
    func errorAddingProduct()
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
        
        (self.homeView.emptyStateView as! HomeEmptyStateView).action.addTarget(self,
                                                                               action: #selector(reloadProducts),
                                                                               for: .touchUpInside)
        
        self.view = self.homeView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.homeView.displayLoading()
        self.presenter.retrieveProducts()
    }
    
    @objc private func reloadProducts() {
        self.homeView.displayLoading()
        self.presenter.retrieveProducts()
    }
}

extension HomeViewController: HomeViewProtocol {
    func productsFetched(with viewModel: [ProductViewModel]) {
        self.homeView.removeLoading()
        self.homeView.removeError()
        self.dataSource.setProducts(with: viewModel)
    }
    
    func errorGettingProducts() {
        self.homeView.removeLoading()
        self.homeView.displayError()
    }
    
    func askUserAboutAddToCart(with viewModel: AlertToCartViewModel) {
        let alert = UIAlertController(title: viewModel.title,
                                      message: viewModel.message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: R.string.localizable.generalAdd(), style: .default) { _ in
            self.presenter.addProduct(viewModel.product)
        }
        let cancelAction = UIAlertAction(title: R.string.localizable.generalCancel(), style: .cancel) { _ in }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func productWasAdded() {
        let alert = UIAlertController(title: R.string.localizable.generalAdded(),
                                      message: nil,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: R.string.localizable.generalOk(), style: .default) { _ in }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func errorAddingProduct() {
        
    }
}

extension HomeViewController: ProductsCollectionViewDataSourceDelegate {
    func didSelect(product: ProductViewModel) {
        self.presenter.userSelected(product: product)
    }
}
