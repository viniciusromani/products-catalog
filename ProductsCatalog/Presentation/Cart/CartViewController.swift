import UIKit

protocol CartViewProtocol: class {
    func cartProductsFetched(with viewModel: [CartProductViewModel])
    func errorGettingProducts()
    
    func productHasBeenRemoved()
    func errorRemovingProduct()
}

class CartViewController: UIViewController {
    
    var cartView: CartView!
    var presenter: CartPresenter
    lazy var dataSource = CartTableViewDataSource(tableView: self.cartView.tableView,
                                                  delegate: self)
    
    init(presenter: CartPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.cartView = CartView()
        
        self.view = self.cartView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.cartView.displayLoading()
        self.presenter.retrieveProducts()
    }
}

extension CartViewController: CartViewProtocol {
    func cartProductsFetched(with viewModel: [CartProductViewModel]) {
        self.cartView.removeLoading()
        self.cartView.removeEmpty()
        self.dataSource.setProducts(with: viewModel)
    }
    
    func errorGettingProducts() {
        self.cartView.removeLoading()
        self.cartView.removeEmpty()
        self.cartView.displayError()
    }
    
    func productHasBeenRemoved() {
        self.dataSource.removeProduct()
    }
    
    func errorRemovingProduct() {
        
    }
}

extension CartViewController: CartTableViewDataSourceDelegate {
    func didClickOnDelete(for product: CartProductViewModel) {
        self.presenter.removeProduct(product)
    }
    
    func noProductsAnymore() {
        self.cartView.displayEmpty()
    }
}
