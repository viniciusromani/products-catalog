import UIKit

protocol EmptableView {
    var emptyStateView: UIView { get set }
    
    func displayEmptyState(at view: UIView)
    func hideEmptyState()
}

extension EmptableView where Self: UIView {
    func displayEmptyState(at view: UIView) {
        view.addSubview(self.emptyStateView)
        
        emptyStateView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(30)
        }
        
        view.bringSubviewToFront(self.emptyStateView)
    }
    
    func hideEmptyState() {
        self.emptyStateView.removeFromSuperview()
    }
}
