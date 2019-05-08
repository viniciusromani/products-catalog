import UIKit

protocol CartViewProtocol: class {
    func cartProductsFetched(with viewModel: [CartProductViewModel])
    func errorGettingProducts()
}

class CartViewController: UIViewController {
    
    var cartView: CartView!
    var presenter: CartPresenter
    lazy var dataSource = CartTableViewDataSource(tableView: self.cartView.tableView)
    
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
        
        self.presenter.retrieveProducts()
    }
}

extension CartViewController: CartViewProtocol {
    func cartProductsFetched(with viewModel: [CartProductViewModel]) {
        self.dataSource.setProducts(with: viewModel)
    }
    
    func errorGettingProducts() {
        
    }
}
