import UIKit

class CartView: UIView, LoadableView {
    let tableView = UITableView()
    private let footer = CartFooterView()
    
    var activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
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
    }
    
    private func addConstraintsToSubviews() {
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        footer.snp.makeConstraints { make in
            make.top.equalTo(self.tableView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension CartView {
    func displayLoading() {
        self.showLoading(at: self)
    }
    
    func removeLoading() {
        self.hideLoading()
    }
}
