import UIKit

class CartView: UIView, LoadableView, EmptableView {
    let tableView = UITableView()
    private let footer = CartFooterView()
    
    var activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    var emptyStateView: UIView = CartEmptyStateView()
    
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
        self.addSubviews([self.tableView,
                          self.footer])
    }
    
    private func formatViews() {
        self.backgroundColor = R.color.backgroundColor()
        
        self.activityIndicator.color = .gray
        
        self.tableView.backgroundColor = R.color.backgroundColor()
        self.tableView.tableFooterView = UIView()
        
        self.footer.layer.shadowRadius = 5
        self.footer.layer.shadowOpacity = 0.1
        self.footer.layer.shadowColor = UIColor.black.cgColor
        self.footer.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
    
    private func addConstraintsToSubviews() {
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        footer.snp.makeConstraints { make in
            make.top.equalTo(self.tableView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(49 + iPhoneXHackInset - 20)
        }
    }
}

extension CartView {
    func setTotal(_ total: String) {
        self.footer.setTotal(total)
    }
    
    func displayLoading() {
        self.showLoading(at: self)
    }
    
    func removeLoading() {
        self.hideLoading()
    }
    
    func displayError() {
        (self.emptyStateView as! CartEmptyStateView).setErrorState()
        self.displayEmptyState(at: self)
    }
    
    func displayEmpty() {
        (self.emptyStateView as! CartEmptyStateView).setEmptyState()
        self.displayEmptyState(at: self)
    }
    
    func removeEmpty() {
        self.hideEmptyState()
    }
}
