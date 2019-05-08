import UIKit

class CartFooterView: UIView {
    private let container = UIStackView()
    private let total = UILabel()
    let buy = UIButton(type: .system)
    
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
        self.container.addArrangedSubviews([self.total,
                                            self.buy])
        self.addSubview(self.container)
    }
    
    private func formatViews() {
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.1
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.backgroundColor = .white
        
        self.container.axis = .horizontal
        self.container.distribution = .fillEqually
        
        self.total.textAlignment = .left
        self.total.numberOfLines = 1
        self.total.textColor = .black
        self.total.text = "R$ 100,00 Total"
        self.total.font = .boldSystemFont(ofSize: 14)
        
        self.buy.layer.cornerRadius = 8
        self.buy.setTitle(R.string.localizable.cartBuy(), for: .normal)
        self.buy.setTitleColor(.white, for: .normal)
        self.buy.titleLabel?.font = .systemFont(ofSize: 18)
        self.buy.backgroundColor = R.color.actionColor()
    }
    
    private func addConstraintsToSubviews() {
        container.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(45)
        }
    }
}

extension CartFooterView {
    func setTotal(_ total: String) {
        self.total.text = total
    }
}
