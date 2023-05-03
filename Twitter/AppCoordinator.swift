import Foundation
import Firebase

final class AppCoordinator: BaseCoordinator {
    override func start() {
        runMessager()
    }
    
    private func runMessager() {
        if Auth.auth().currentUser == nil {
            runMAuth()
        } else {
            runTabbar()
        }
    }
    
    private func runMAuth() {
        let coordinator = MAuthCoordinator(router: router)
        coordinator.onFlowDidFinish = {
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runTwitter() {
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
