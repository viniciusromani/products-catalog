import UIKit

class CartEmptyStateView: UIView {
    private let message = UILabel()
    let action = UIButton(type: .system)
    
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
        self.addSubviews([self.message,
                          self.action])
    }
    
    private func formatViews() {
        self.backgroundColor = .clear
        
        self.message.text = R.string.localizable.cartEmptyMessage()
        self.message.numberOfLines = 0
        self.message.textColor = .black
        self.message.font = .systemFont(ofSize: 14)
        self.message.textAlignment = .center
        
        self.action.setTitleColor(R.color.actionColor(), for: .normal)
        self.action.titleLabel?.font = .systemFont(ofSize: 16)
    }
    
    private func addConstraintsToSubviews() {
        message.snp.makeConstraints { make in
            make.top.left.right.centerX.equalToSuperview()
        }
        
        action.snp.makeConstraints { make in
            make.top.equalTo(self.message.snp.bottom).offset(12)
            make.left.right.bottom.centerX.equalToSuperview()
        }
    }
}

extension CartEmptyStateView {
    func setErrorState() {
        self.message.text = R.string.localizable.generalNetworkError()
        self.action.setTitle(R.string.localizable.generalTryAgain(), for: .normal)
    }
    
    func setEmptyState() {
        self.message.text = R.string.localizable.cartEmptyMessage()
        self.action.isHidden = true
        self.action.isEnabled = false
    }
}
