//
//  LoginController.swift
//  Twitter
//
//  Created by Vladimir Fibe on 21.02.2022.
//

import UIKit

class LoginController: UIViewController {
  // MARK: - Properties
  
  private let logoImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "TwitterLogo"))
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private let emailTextField: UITextField = Utilities.shared.textField(placeholder: "Email")
  
  private let passwordTextField: UITextField = Utilities.shared.textField(placeholder: "Password")
  
  private lazy var emailContainerView: UIView = Utilities.shared.inputContainerView(systemName: "envelope", textField: emailTextField)
 
  
  private lazy var passwordContainerView: UIView = Utilities.shared.inputContainerView(systemName: "lock", textField: passwordTextField)

  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  // MARK: - Selectors
  
  // MARK: - Helpers
  
  func configureUI() {
    passwordTextField.isSecureTextEntry = true
    view.backgroundColor = .twitterBlue
    navigationController?.navigationBar.barStyle = .black
    navigationController?.navigationBar.isHidden = true
    
    view.addSubview(logoImageView)
    logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
    logoImageView.setDimensions(width: 150, height: 150)
    
    let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
    stack.axis = .vertical
    
    view.addSubview(stack)
    stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
  }
}
