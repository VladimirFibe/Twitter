import UIKit

extension UIFont {
    static func avenirBook(size: CGFloat) -> UIFont {
        UIFont(name: "Avenir-Book", size: size) ?? .systemFont(ofSize: size)
    }
    static func avenirMedium(size: CGFloat) -> UIFont {
        UIFont(name: "Avenir-Medium", size: size) ?? .systemFont(ofSize: size)
    }
}

