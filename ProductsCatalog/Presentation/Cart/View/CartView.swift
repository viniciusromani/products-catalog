import UIKit

class CartView: UIView {
    private let label = UILabel()
    
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
        self.addSubview(self.label)
    }
    
    private func formatViews() {
        self.backgroundColor = .white
        
        self.label.text = "Cart"
        self.label.textColor = .black
        self.label.font = .systemFont(ofSize: 18)
    }
    
    private func addConstraintsToSubviews() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
