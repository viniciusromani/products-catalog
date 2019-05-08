import UIKit

class CartTableViewDataSource: NSObject {
    private let tableView: UITableView
    private var viewModel: [CartProductViewModel]?
    
    init(tableView: UITableView) {
        self.tableView = tableView
        
        super.init()
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerCell(CartProductTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension CartTableViewDataSource: UITableViewDelegate {
    
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
        cell.set(with: viewModel[indexPath.row])
        return cell
    }
}

extension CartTableViewDataSource {
    func setProducts(with viewModel: [CartProductViewModel]) {
        self.viewModel = viewModel
        self.tableView.reloadAnimated()
    }
}
