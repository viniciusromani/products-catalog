import UIKit
import SnapKit

class HomeView: UIView, LoadableView, EmptableView {
    let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    var emptyStateView: UIView = HomeEmptyStateView()
    
    init() {
        super.init(frame: .zero)
        self.buildViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func buildViews() {
        self.addSubviews()
        self.formatViews()
        self.addConstraintsToSubviews()
    }
    
    private func addSubviews() {
        self.addSubview(self.collection)
    }
    
    private func formatViews() {
        self.backgroundColor = R.color.backgroundColor()
        
        self.activityIndicator.color = .gray
        
        self.collection.backgroundColor = R.color.backgroundColor()
        self.collection.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    private func addConstraintsToSubviews() {
        collection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension HomeView {
    func displayLoading() {
        self.showLoading(at: self)
    }
    
    func removeLoading() {
        self.hideLoading()
    }
    
    func displayError() {
        (self.emptyStateView as! HomeEmptyStateView).setErrorState()
        self.displayEmptyState(at: self)
    }
    
    func removeError() {
        self.hideEmptyState()
    }
}
