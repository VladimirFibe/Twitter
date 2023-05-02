import UIKit

final class ExploreCoordinator: BaseCoordinator {
    var onFlowDidFinish: Callback?
    var menuHandler: Callback?
    
    override func start() {
        let controller = makeExplore()
        router.setRootModule(controller)
    }
}

extension ExploreCoordinator {
    private func makeExplore() -> BaseViewControllerProtocol {
        return ExploreViewController()
    }
}

