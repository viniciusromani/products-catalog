import UIKit

protocol CartTableViewDataSourceDelegate {
    func didClickOnDelete(for product: CartProductViewModel)
    func noProductsAnymore()
}

class CartTableViewDataSource: NSObject {
    private let tableView: UITableView
    private let delegate: CartTableViewDataSourceDelegate
    private var viewModel: [CartProductViewModel]?
    
    private var indexPathToBeRemoved: IndexPath?
    
    init(tableView: UITableView,
         delegate: CartTableViewDataSourceDelegate) {
        self.tableView = tableView
        self.delegate = delegate
        
        super.init()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerCell(CartProductTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension CartTableViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        guard let viewModel = self.viewModel else {
            return .none
        }
        return viewModel.count > 0 ? .delete: .none
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let product = self.viewModel?[indexPath.row] else {
            return
        }
        
        self.indexPathToBeRemoved = indexPath
        self.delegate.didClickOnDelete(for: product)
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension CartTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModelSize = self.viewModel?.count else {
            return 0
        }
        return viewModelSize
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = self.viewModel else {
            return tableView.dequeueReusableCell(for: indexPath)
        }
        
        let cell: CartProductTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        if let toRemove = self.indexPathToBeRemoved, toRemove == indexPath {
            cell.displayLoading()
            return cell
        }
        
        cell.removeLoading()
        cell.delete.tag = indexPath.row
        cell.delete.addTarget(self, action: #selector(deleteTapped(_:)), for: .touchUpInside)
        cell.set(with: viewModel[indexPath.row])
        return cell
    }
    
    @objc private func deleteTapped(_ sender: UIButton) {
        guard let viewModel = self.viewModel?[sender.tag] else {
            return
        }
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        self.indexPathToBeRemoved = indexPath
        self.delegate.didClickOnDelete(for: viewModel)
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}

extension CartTableViewDataSource {
    func setProducts(with viewModel: [CartProductViewModel]) {
        self.viewModel = viewModel
        self.tableView.reloadAnimated()
    }
    
    func removeProduct() {
        guard let indexPath = self.indexPathToBeRemoved else {
            return
        }
        
        self.viewModel?.remove(at: indexPath.row)
        self.indexPathToBeRemoved = nil
        
        self.tableView.deleteRows(at: [indexPath], with: .fade)
        if self.viewModel?.count ?? 0 == 0 {
            self.delegate.noProductsAnymore()
        }
    }
}
