//
//  FeedController.swift
//  Twitter
//
//  Created by Vladimir Fibe on 21.02.2022.
//

import UIKit

class FeedController: UITabBarController {
  // MARK: - Properties
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewControllers()
  }
  
  // MARK: - Helpers
  
  func configureViewControllers() {
    view.backgroundColor = .white
    let imageView = UIImageView(image: UIImage(named: "TwitterLogoBlue"))
    imageView.contentMode = .scaleAspectFit
    navigationItem.titleView = imageView
  }
}
