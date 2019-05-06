import UIKit

protocol HomeViewProtocol: class {
    func productsFetched()
    func errorGettingProducts()
}

class HomeViewController: UIViewController {
    
    var homeView: HomeView!
    var presenter: HomePresenter
    
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
        
        self.presenter.retrieveProducts()
    }
}

extension HomeViewController: HomeViewProtocol {
    func productsFetched() {
        print("ok")
    }
    
    func errorGettingProducts() {
        print("error")
    }
}
