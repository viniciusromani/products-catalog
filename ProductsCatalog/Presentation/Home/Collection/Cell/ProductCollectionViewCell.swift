import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    private let image = UIImageView()
    private let name = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        self.addSubviews([self.image,
                          self.name])
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
    }
    
    private func addConstraintsToSubviews() {
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.height.equalTo(175)
            make.centerX.equalToSuperview()
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(self.image.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}

extension ProductCollectionViewCell {
    func setContent(with viewModel: ProductViewModel) {
        self.image.setImage(with: viewModel.imageURL)
//        string.rangeOfCharacter(from: .uppercaseLetters)
        
        self.name.text = viewModel.name.lowercased().capitalized
    }
}
