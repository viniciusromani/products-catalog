import UIKit

class ProductsCollectionViewDataSource: NSObject {
    private let collection: UICollectionView
    private var viewModel: [ProductViewModel]?
    
    init(collection: UICollectionView) {
        self.collection = collection
        
        super.init()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        
        collection.collectionViewLayout = flowLayout
        collection.delegate = self
        collection.dataSource = self
        collection.registerCell(ProductCollectionViewCell.self)
    }
}

extension ProductsCollectionViewDataSource: UICollectionViewDelegate {
    
}

extension ProductsCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModelSize = self.viewModel?.count else {
            return 0
        }
        return viewModelSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = self.viewModel else {
            return collectionView.dequeueReusableCell(for: indexPath)
        }
        
        let cell: ProductCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setContent(with: viewModel[indexPath.row])
        return cell
    }
}

extension ProductsCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = CGFloat(280)
        let cellSpacing = (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 10
        let halfOfWidth = (collectionView.bounds.width - (cellSpacing * 2)) / 2
        let size = CGSize(width: halfOfWidth - (cellSpacing * 2), height: cellHeight)
        return size
    }
}

extension ProductsCollectionViewDataSource {
    func setProducts(with viewModel: [ProductViewModel]) {
        self.viewModel = viewModel
        self.collection.reloadAnimated()
    }
}
