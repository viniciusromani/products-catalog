import UIKit
import SDWebImage

extension UIImageView {
    func setImage(with url: URL?,
                  placeholder placeholderImage: UIImage? = nil) {
        self.sd_setImage(with: url, placeholderImage: placeholderImage, options: []) { imageSet, error, cacheType, url in
            guard error == nil else {
                self.image = placeholderImage
                return
            }
        }
    }
}
