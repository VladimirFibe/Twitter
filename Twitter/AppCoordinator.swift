import Foundation
import Firebase

final class AppCoordinator: BaseCoordinator {
    override func start() {
        if Auth.auth().currentUser == nil {
            runAuth()
        } else {
            runTabbar()
        }
    }
    
    private func runAuth() {
        let coordinator = AuthCoordinator(router: router)
        coordinator.onFlowDidFinish = {
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runTabbar() {
        let coordinator = TabBarCoordinator(router: router)
        coordinator.onFlowDidFinish = {
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
