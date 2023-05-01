import UIKit

final class NotificationsCoordinator: BaseCoordinator {
    var onFlowDidFinish: Callback?
    var menuHandler: Callback?
    
    override func start() {
        let controller = makeNotifications()
        router.setRootModule(controller)
    }
}

extension NotificationsCoordinator {
    private func makeNotifications() -> BaseViewControllerProtocol {
        return NotificationsViewController()
    }
}
