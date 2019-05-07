import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    private let image = UIImageView()
    private let name = UILabel()
    private let regularPrice = UILabel()
    private var discountContainer: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.buildViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.discountContainer?.removeFromSuperview()
    }
    
    private func buildViews() {
        self.addSubviews()
        self.formatSubviews()
        self.addConstraintsToSubviews()
    }
    
    private func addSubviews() {
        self.addSubviews([self.image,
                          self.name,
                          self.regularPrice])
    }
    
    private func formatSubviews() {
        self.clipsToBounds = true
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = R.color.dividerCellColor()?.cgColor
        
        self.image.contentMode = .scaleAspectFit
        
        self.name.numberOfLines = 2
        self.name.textAlignment = .center
        self.name.textColor = .black
        self.name.font = .boldSystemFont(ofSize: 12)
        
        self.regularPrice.textAlignment = .center
        self.regularPrice.textColor = .black
        self.regularPrice.font = .boldSystemFont(ofSize: 18)
    }
    
    private func addConstraintsToSubviews() {
        image.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(200)
            make.centerX.equalToSuperview()
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(self.image.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
        }
        
        regularPrice.snp.makeConstraints { make in
            make.top.equalTo(self.name.snp.bottom).offset(4)
            make.left.right.equalTo(self.name)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}

extension ProductCollectionViewCell {
    func setContent(with viewModel: ProductViewModel) {
        self.image.setImage(with: viewModel.imageURL)
        self.name.text = viewModel.name.lowercased().capitalized
        self.regularPrice.text = viewModel.regularPrice
        if viewModel.isOnSale {
            self.setSalePrice(with: viewModel)
        }
    }
    
    private func setSalePrice(with viewModel: ProductViewModel) {
        self.discountContainer = UIView()
        let discount = UILabel()
        discount.text = "\(viewModel.discountPercentage ?? "") OFF"
        discount.textColor = .red
        discount.font = .boldSystemFont(ofSize: 12)
        
        let promotional = UILabel()
        promotional.text = viewModel.regularPrice
        promotional.textColor = .gray
        promotional.font = .systemFont(ofSize: 12)
        let attributes = [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
                          NSAttributedString.Key.strikethroughColor: UIColor.gray] as [NSAttributedString.Key : Any]
        let attributedString = NSAttributedString(string: viewModel.regularPrice,
                                                  attributes: attributes)
        promotional.attributedText = attributedString
        
        guard self.discountContainer != nil else {
            return
        }
        self.regularPrice.removeFromSuperview()
        self.discountContainer?.addSubviews([discount, promotional])
        self.addSubviews([self.regularPrice, self.discountContainer!])
        
        regularPrice.snp.makeConstraints { make in
            make.top.equalTo(self.name.snp.bottom)
            make.left.right.equalTo(self.name)
        }
        discountContainer?.snp.makeConstraints { make in
            make.top.equalTo(self.regularPrice.snp.bottom)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(6)
        }
        discount.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
        }
        promotional.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(discount.snp.right).offset(4)
        }
    }
}
