import UIKit

final class ContainerViewController: BaseViewController {
    var tabBar: UITabBarController!
    var menu: UIViewController!
    var isMove = false
    var width: CGFloat {
        tabBar.view.frame.width - 140
    }
    private func configureMenu() {
        if menu == nil {
            menu = MenuViewController()
            view.insertSubview(menu.view, at: 0)
            addChild(menu)
            menu.view.frame.origin.x = -width
        }
    }
    
    private func showMenu() {
        if isMove {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0) {
                self.tabBar.view.frame.origin.x = self.width
                self.menu.view.frame.origin.x = 0
            }
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0) {
                self.tabBar.view.frame.origin.x = 0
                self.menu.view.frame.origin.x = -self.width
            }
        }
    }
    
    func toggleMenu() {
        configureMenu()
        isMove.toggle()
        showMenu()
    }
}
