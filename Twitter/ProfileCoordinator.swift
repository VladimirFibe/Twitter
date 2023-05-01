import UIKit

final class ProfileCoordinator: BaseCoordinator {
    var onFlowDidFinish: Callback?
    var menuHandler: Callback?
    
    override func start() {
        let controller = makeProfile()
        router.setRootModule(controller)
    }
}

extension ProfileCoordinator {
    private func makeProfile() -> BaseViewControllerProtocol {
        let navigation = ProfileNavigation {
            self.onFlowDidFinish?()
        } menuHandler: {
            self.menuHandler?()
        }
        return ProfileViewController(navigation: navigation)
    }
}
