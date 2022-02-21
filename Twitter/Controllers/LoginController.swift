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

  private let loginButton: UIButton = {
    let button = Utilities.shared.loginButton("Log In")
    button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    return button
  }()
  
  private let dontHaveAccountButton: UIButton = {
    let button = Utilities.shared.attibutedButton("Don't have an account? ", "Sign Up")
    button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  // MARK: - Selectors
  
  @objc func handleLogin() {
    print("Login")
  }
  
  @objc func handleSignUp() {
    let controller = RegistrationController()
    navigationController?.pushViewController(controller, animated: true)
  }
  // MARK: - Helpers
  
  func configureUI() {
    passwordTextField.isSecureTextEntry = true
    view.backgroundColor = .twitterBlue
    navigationController?.navigationBar.barStyle = .black
    navigationController?.navigationBar.isHidden = true
    
    let stack = UIStackView(arrangedSubviews: [logoImageView, emailContainerView, passwordContainerView, loginButton])
    stack.axis = .vertical
    stack.spacing = 20
    let margins = view.layoutMarginsGuide
    view.addSubview(stack)
    stack.anchor(top: margins.topAnchor, left: margins.leftAnchor, right: margins.rightAnchor)
    
    view.addSubview(dontHaveAccountButton)
    dontHaveAccountButton.anchor(left: margins.leftAnchor, bottom: margins.bottomAnchor, right: margins.rightAnchor)
  }
}
