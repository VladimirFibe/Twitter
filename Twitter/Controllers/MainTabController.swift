//
//  MainTabController.swift
//  Twitter
//
//  Created by Vladimir Fibe on 20.02.2022.
//

import UIKit

class MainTabController: UITabBarController {
  // MARK: - Properties
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewControllers()
  }
  
  // MARK: - Helpers
  
  func configureViewControllers() {
    let feed = templateNavigationController(systemName: "house",
                                            rootViewController: FeedController())
    let explore = templateNavigationController(systemName: "magnifyingglass",
                                               rootViewController: ExploreController())
    let notifications = templateNavigationController(systemName: "heart",
                                                     rootViewController: NotificationsController())
    let conversations = templateNavigationController(systemName: "envelope",
                                                     rootViewController: ConversationsController())
    
    viewControllers = [feed, explore, notifications, conversations]

  }
  
  func templateNavigationController(systemName: String, rootViewController: UIViewController) -> UINavigationController {
    let controller = UINavigationController(rootViewController: rootViewController)
    controller.tabBarItem.image = UIImage(systemName: systemName)
    controller.navigationBar.barTintColor = .gray
    controller.navigationItem.title = systemName
    return controller
  }
}
