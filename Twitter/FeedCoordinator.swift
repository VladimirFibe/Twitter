import UIKit

final class FeedCoordinator: BaseCoordinator {
    var onFlowDidFinish: Callback?
    var menuHandler: Callback?
    
    override func start() {
        let controller = makeFeed()
        router.setRootModule(controller)
    }
}

extension FeedCoordinator {
    private func makeFeed() -> BaseViewControllerProtocol {
        return FeedViewController()
    }
}
