import Foundation

final class AuthCoordinator: BaseCoordinator {
    var onFlowDidFinish: Callback?
    override func start() {
        runSignIn()
    }
    
    private func runSignIn() {
        let controller = makeSignIn()
        router.setRootModule(controller)
    }
    
    private func runSignUp() {
        let controller = makeSignUp()
        router.push(controller)
    }
}

extension AuthCoordinator {
    private func makeSignIn() -> BaseViewControllerProtocol {
        let navigation = SignInNavigation {
            self.runSignUp()
        } signInHadler: {
            self.onFlowDidFinish?()
        }
        return SignInViewController(navigation: navigation)
    }
    
    private func makeSignUp() -> BaseViewControllerProtocol {
        let navigation = SignUpNavigation {
            print("SignUp")
        }
        return SignUpViewController(navigation: navigation)
    }
}
