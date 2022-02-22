//
//  MainTabController.swift
//  Twitter
//
//  Created by Vladimir Fibe on 20.02.2022.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
  // MARK: - Properties
  
  let actionButton: UIButton = {
    let button = UIButton(type: .system)
    button.tintColor = .white
    button.backgroundColor = .twitterBlue
    button.setImage(UIImage(named: "new"), for: .normal)
    button.layer.cornerRadius = 28.0
    button.addTarget(self, action: #selector(acitionButtonTapped), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    authenticateUserAndConfigureUI()
  }
  
  // MARK: - API
  
  func authenticateUserAndConfigureUI() {
    if Auth.auth().currentUser == nil {
      DispatchQueue.main.async {
        let controller = UINavigationController(rootViewController: LoginController())
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
      }
    } else {
      configureViewControllers()
      configureUI()
    }
  }
  
  func logout() {
    do {
      try Auth.auth().signOut()
    } catch {
      print("DEBUG: \(error.localizedDescription)")
    }
  }
  // MARK: - Selectors
  
  @objc func acitionButtonTapped() {
    logout()
  }
  
  // MARK: - Helpers
  
  func configureUI() {
    view.addSubview(actionButton)
    actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                        right: view.rightAnchor,
                        paddingBottom: 64,
                        paddingRight: 16,
                        width: 56,
                        height: 56)
  }
  
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
    controller.navigationItem.title = systemName
    return controller
  }
}
