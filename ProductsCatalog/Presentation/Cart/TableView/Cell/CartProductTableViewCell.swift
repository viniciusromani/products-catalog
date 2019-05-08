import UIKit

class CartProductTableViewCell: UITableViewCell {
    private let productImage = UIImageView()
    private let infoContainer = UIView()
    private let name = UILabel()
    private let regularPrice = UILabel()
    let quantity = UIButton(type: .system)
    let delete = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.buildViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.buildViews()
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
    func set(with viewModel: CartProductViewModel) {
        self.productImage.setImage(with: viewModel.imageURL)
        self.name.text = viewModel.name
        self.regularPrice.text = viewModel.regularPrice
        self.quantity.setTitle("x1", for: .normal)
    }
}