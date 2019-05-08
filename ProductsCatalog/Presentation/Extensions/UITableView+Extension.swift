import UIKit

extension UITableView {
    func registerCell(_ cellClass: UITableViewCell.Type) {
        self.register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }
    
    func dequeueReusableCell<T>(for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Cell of type \(String(describing: T.self)) was not registered on collection view")
        }
        return cell
    }
    
    func reloadAnimated() {
        UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.reloadData()
        }, completion: nil)
    }
}
