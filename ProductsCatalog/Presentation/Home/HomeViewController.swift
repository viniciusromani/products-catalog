import UIKit

protocol HomeViewProtocol: class {
    
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
}

extension HomeViewController: HomeViewProtocol {
    
}
