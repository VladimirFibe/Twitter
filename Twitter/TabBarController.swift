import UIKit

final class TabBarController: UITabBarController, BaseViewControllerProtocol {
    var onRemoveFromNavigationStack: (() -> Void)?
    var onDidDismiss: (() -> Void)?
}
