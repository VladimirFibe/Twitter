import Foundation

final class MAuthCoordinator: BaseCoordinator {
    var onFlowDidFinish: Callback?
    
    override func start() {
        runLogin()
    }
    
    private func runLogin() {
        let controller = makeLogin()
        router.setRootModule(controller)
    }
}

extension MAuthCoordinator {
    private func makeLogin() -> BaseViewControllerProtocol {
        MLoginViewController()
    }
}
