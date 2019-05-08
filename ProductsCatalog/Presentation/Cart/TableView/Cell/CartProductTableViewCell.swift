import UIKit

class CartProductTableViewCell: UITableViewCell, LoadableView {
    private let productImage = UIImageView()
    private let infoContainer = UIView()
    private let name = UILabel()
    private let regularPrice = UILabel()
    private var salePrice: UILabel?
    let quantity = UIButton(type: .system)
    let delete = UIButton(type: .system)
    
    var activityIndicator = UIActivityIndicatorView.init(style: .gray)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.buildViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.buildViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.salePrice?.removeFromSuperview()
    }
    
    private func buildViews() {
        self.addSubviews()
        self.formatSubviews()
        self.addConstraintsToSubviews()
    }
    
    private func addSubviews() {
        self.infoContainer.addSubviews([self.name,
                                        self.regularPrice])
        self.addSubviews([self.productImage,
                          self.infoContainer,
                          self.quantity,
                          self.delete])
    }
    
    private func formatSubviews() {
        self.backgroundColor = .white
        
        self.productImage.contentMode = .scaleAspectFit
        
        self.name.numberOfLines = 2
        self.name.textAlignment = .left
        self.name.textColor = .black
        self.name.font = .systemFont(ofSize: 14)
        
        self.regularPrice.textAlignment = .left
        self.regularPrice.textColor = .black
        self.regularPrice.font = .boldSystemFont(ofSize: 14)
        
        self.quantity.layer.cornerRadius = 4
        self.quantity.layer.borderColor = R.color.actionColor()?.cgColor
        self.quantity.layer.borderWidth = 1
        self.quantity.setTitle("", for: .normal)
        self.quantity.setTitleColor(R.color.actionColor(), for: .normal)
        self.quantity.titleLabel?.font = .boldSystemFont(ofSize: 16)
        self.quantity.backgroundColor = .clear
        
        self.delete.setTitle(R.string.localizable.generalDelete(), for: .normal)
        self.delete.setTitleColor(R.color.actionColor(), for: .normal)
        self.delete.titleLabel?.font = .systemFont(ofSize: 12)
    }
    
    private func addConstraintsToSubviews() {
        productImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(16)
            make.height.equalTo(120)
            make.width.equalTo(80)
        }
        
        infoContainer.snp.makeConstraints { make in
            make.left.equalTo(self.productImage.snp.right).offset(10)
            make.centerY.equalTo(self.productImage)
        }
        
        name.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        regularPrice.snp.makeConstraints { make in
            make.top.equalTo(self.name.snp.bottom).offset(10)
            make.left.bottom.equalToSuperview()
        }
        
        quantity.snp.makeConstraints { make in
            make.top.equalTo(self.name)
            make.left.equalTo(self.name.snp.right).offset(10)
            make.right.equalToSuperview().inset(16)
            make.width.equalTo(48)
            make.height.equalTo(35)
        }
        
        delete.snp.makeConstraints { make in
            make.top.equalTo(self.quantity.snp.bottom).offset(10)
            make.left.right.equalTo(self.quantity)
        }
    }
}

extension CartProductTableViewCell {
    func displayLoading() {
        self.layoutIfNeeded()
        self.showLoading(at: self)
    }
    
    func removeLoading() {
        self.hideLoading()
    }
    
    func set(with viewModel: CartProductViewModel) {
        self.productImage.setImage(with: viewModel.imageURL)
        self.name.text = viewModel.name
        self.regularPrice.text = viewModel.regularPrice
        self.quantity.setTitle("x1", for: .normal)
        if viewModel.isOnSale {
            self.setSalePrice(with: viewModel)
        }
    }
    
    private func setSalePrice(with viewModel: CartProductViewModel) {
        self.salePrice = UILabel()
        self.salePrice?.textAlignment = .left
        self.salePrice?.textColor = .gray
        self.salePrice?.font = .systemFont(ofSize: 14)
        let attributes = [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                          NSAttributedString.Key.strikethroughColor: UIColor.gray] as [NSAttributedString.Key : Any]
        let attributedString = NSAttributedString(string: viewModel.regularPrice,
                                                  attributes: attributes)
        self.salePrice?.attributedText = attributedString
        
        self.regularPrice.text = viewModel.promotionalPrice
        
        guard self.salePrice != nil else {
            return
        }
        self.infoContainer.addSubview(self.salePrice!)
        
        self.salePrice?.snp.makeConstraints { make in
            make.top.equalTo(self.regularPrice)
            make.left.equalTo(self.regularPrice.snp.right).offset(8)
            make.bottom.equalToSuperview()
        }
    }
}
