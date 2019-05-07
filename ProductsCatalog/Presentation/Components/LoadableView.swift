import UIKit

protocol LoadableView {
    var activityIndicator: UIActivityIndicatorView { get set }
    
    func showLoading(at view: UIView)
    func hideLoading()
}

extension LoadableView where Self: UIView {
    func showLoading(at view: UIView) {
        let loadingView = UIView()
        loadingView.backgroundColor = view.backgroundColor
        loadingView.addSubview(self.activityIndicator)
        
        view.addSubview(loadingView)
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(loadingView)
        }
        
        view.bringSubviewToFront(loadingView)
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        guard let loadingView = self.activityIndicator.superview else {
            return
        }
        loadingView.removeFromSuperview()
    }
}
