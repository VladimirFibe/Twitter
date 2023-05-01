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
        let modules = [makeFeed(), makeExplore(), makeNotifications(), makeMessages()]
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
    
    private func makeFeed() -> (BaseCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let coordinator = FeedCoordinator(router: RouterImpl(rootController: navigationController))
        navigationController.tabBarItem = tabItem(for: .feed)
        return (coordinator, navigationController)
    }
    
    private func makeExplore() -> (BaseCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let coordinator = ExploreCoordinator(router: RouterImpl(rootController: navigationController))
        navigationController.tabBarItem = tabItem(for: .search)
        return (coordinator, navigationController)
    }
    
    private func makeNotifications() -> (BaseCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let coordinator = NotificationsCoordinator(router: RouterImpl(rootController: navigationController))
        navigationController.tabBarItem = tabItem(for: .notifications)
        return (coordinator, navigationController)
    }
    
    private func makeMessages() -> (BaseCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let coordinator = MessagesCoordinator(router: RouterImpl(rootController: navigationController))
        navigationController.tabBarItem = tabItem(for: .messages)
        return (coordinator, navigationController)
    }
    
    private func makeProfile() -> (BaseCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let coordinator = ProfileCoordinator(router: RouterImpl(rootController: navigationController))
        coordinator.onFlowDidFinish = onFlowDidFinish
        coordinator.menuHandler = {
            self.container.toggleMenu()
        }
//        navigationController.tabBarItem = tabItem(for: .profile)
        return (coordinator, navigationController)
    }
    
    private func tabItem(for type: TabItem) -> UITabBarItem {
        let item = UITabBarItem(
            title: nil,
            image: UIImage(named: type.icon),
            selectedImage: UIImage(named: type.iconFill)
        )
        item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        return item
    }
}
