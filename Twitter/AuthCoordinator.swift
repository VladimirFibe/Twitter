import Foundation

final class AuthCoordinator: BaseCoordinator {
    var onFlowDidFinish: Callback?
    override func start() {
        runAuth()
    }
    
    private func runAuth() {
        let controller = makeSignIn()
        router.setRootModule(controller)
    }
}

extension AuthCoordinator {
    private func makeSignIn() -> BaseViewControllerProtocol {
        return SignInViewController()
    }
}
