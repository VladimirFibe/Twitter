import UIKit

final class MessagesCoordinator: BaseCoordinator {
    var onFlowDidFinish: Callback?
    var menuHandler: Callback?
    
    override func start() {
        let controller = makeMessages()
        router.setRootModule(controller)
    }
}

extension MessagesCoordinator {
    private func makeMessages() -> BaseViewControllerProtocol {
        return MessagesViewController()
    }
}
