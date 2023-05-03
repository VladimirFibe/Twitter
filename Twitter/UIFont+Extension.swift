import UIKit

extension UIFont {
    static func avenirBook(size: CGFloat) -> UIFont {
        UIFont(name: "Avenir-Book", size: size) ?? .systemFont(ofSize: size)
    }
}

