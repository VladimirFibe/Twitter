import Foundation
import FirebaseAuth

final class AppCoordinator: BaseCoordinator {
    var authListener: AuthStateDidChangeListenerHandle?
    
    override func start() {
        if let authListener = authListener {
            Auth.auth().removeStateDidChangeListener(authListener)
        }
        authListener = Auth.auth().addStateDidChangeListener { auth, user in
            DispatchQueue.main.async {
                if user == nil {
                    self.runMAuth()
                } else {
                    self.runTabbar()
                }
            }
        }
    }
    
    private func runMAuth() {
        let coordinator = MAuthCoordinator(router: router)
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
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runTabbar() {
        let coordinator = TabBarCoordinator(router: router)
        addDependency(coordinator)
        coordinator.start()
    }
}
