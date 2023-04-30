import Foundation
import Firebase

final class AppCoordinator: BaseCoordinator {
    override func start() {
        if Auth.auth().currentUser == nil {
            runAuth()
        } else {
            print("main")
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
}
