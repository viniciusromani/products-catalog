import UIKit

protocol HomeViewProtocol: class {
    func productsFetched(with viewModel: [ProductViewModel])
    func errorGettingProducts()
}

class HomeViewController: UIViewController {
    
    var homeView: HomeView!
    var presenter: HomePresenter
    lazy var dataSource = ProductsCollectionViewDataSource(collection: self.homeView.collection)
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
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
}
