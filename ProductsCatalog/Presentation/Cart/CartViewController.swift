import UIKit

protocol CartViewProtocol: class {
    
}

class CartViewController: UIViewController {
    
    var cartView: CartView!
    var presenter: CartPresenter
    
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
}

extension CartViewController: CartViewProtocol {
    
}
