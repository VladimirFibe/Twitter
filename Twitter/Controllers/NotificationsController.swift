//
//  NotificationsController.swift
//  Twitter
//
//  Created by Vladimir Fibe on 21.02.2022.
//

import UIKit

class NotificationsController: UITabBarController {
  // MARK: - Properties
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewControllers()
  }
  
  // MARK: - Helpers
  
  func configureViewControllers() {
    view.backgroundColor = .white
    navigationItem.title = "Notifications"
  }
}
