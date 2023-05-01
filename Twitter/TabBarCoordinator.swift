import UIKit

final class TabBarCoordinator: BaseCoordinator {
    var onFlowDidFinish: Callback?
    
    override func start() {
        runTab()
    }
    
    private func runTab() {
        let tabBar = makeTabBar()
        router.setRootModule(tabBar, hideBar: true)
        
        let modules = [makeProfile()]
        modules.forEach { coordinator, _ in
            addDependency(coordinator)
            coordinator.start()
        }
        let viewControllers = modules.map { $0.1 }
        tabBar.setViewControllers(viewControllers, animated: false)
    }
}

extension TabBarCoordinator {
    private func makeTabBar() -> BaseViewControllerProtocol & UITabBarController {
        TabBarController()
    }
    
    private func makeProfile() -> (BaseCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let coordinator = ProfileCoordinator(router: RouterImpl(rootController: navigationController))
        coordinator.onFlowDidFinish = onFlowDidFinish
        navigationController.tabBarItem = tabItem(for: .profile)
        return (coordinator, navigationController)
    }
    
    private func tabItem(for type: TabItem) -> UITabBarItem {
        UITabBarItem(title: nil, image: UIImage(systemName: "person"), tag: 0)
    }
}
