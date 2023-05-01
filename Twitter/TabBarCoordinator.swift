import UIKit

final class TabBarCoordinator: BaseCoordinator {
    var onFlowDidFinish: Callback?
    var container: ContainerViewController!
    override func start() {
        runMain()
    }
    
    private func runMain() {
        let controller = makeMain()
        router.setRootModule(controller, hideBar: true)
    }
}

extension TabBarCoordinator {
    private func makeMain() -> BaseViewControllerProtocol {
        container = ContainerViewController()
        let tabBar = makeTabBar()
        container.tabBar = tabBar
        container.view.addSubview(tabBar.view)
        container.addChild(tabBar)
        let modules = [makeProfile()]
        modules.forEach { coordinator, _ in
            addDependency(coordinator)
            coordinator.start()
        }
        let viewControllers = modules.map { $0.1 }
        tabBar.setViewControllers(viewControllers, animated: false)
        return container
    }
    
    private func makeTabBar() -> BaseViewControllerProtocol & UITabBarController {
        TabBarController()
    }
    
    private func makeProfile() -> (BaseCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let coordinator = ProfileCoordinator(router: RouterImpl(rootController: navigationController))
        coordinator.onFlowDidFinish = onFlowDidFinish
        coordinator.menuHandler = {
            self.container.toggleMenu()
        }
        navigationController.tabBarItem = tabItem(for: .profile)
        return (coordinator, navigationController)
    }
    
    private func tabItem(for type: TabItem) -> UITabBarItem {
        UITabBarItem(title: nil, image: UIImage(systemName: "person"), tag: 0)
    }
}
