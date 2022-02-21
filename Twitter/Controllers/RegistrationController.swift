//
//  RegistrationController.swift
//  Twitter
//
//  Created by Vladimir Fibe on 21.02.2022.
//

import UIKit

class RegistrationController: UIViewController {
  // MARK: - Properties
  
  private let plusPhotoButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "photo"), for: .normal)
    button.tintColor = .white
    button.addTarget(self, action: #selector(handleAddPhoto), for: .touchUpInside)
    return button
  }()
  
  private let emailTextField: UITextField = Utilities.shared.textField(placeholder: "Email")
  
  private let passwordTextField: UITextField = Utilities.shared.textField(placeholder: "Password")
  
  private let fullnameTextField: UITextField = Utilities.shared.textField(placeholder: "Full Name")
  
  private let usernameTextField: UITextField = Utilities.shared.textField(placeholder: "Username")
  
  private lazy var emailContainerView: UIView = Utilities.shared.inputContainerView(systemName: "envelope", textField: emailTextField)
 
  private lazy var passwordContainerView: UIView = Utilities.shared.inputContainerView(systemName: "lock", textField: passwordTextField)

  private lazy var fullnameContainerView: UIView = Utilities.shared.inputContainerView(systemName: "person", textField: fullnameTextField)
 
  private lazy var usernameContainerView: UIView = Utilities.shared.inputContainerView(systemName: "person", textField: usernameTextField)

  private let signupButton: UIButton = {
    let button = Utilities.shared.loginButton("Sign Up")
    button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    return button
  }()
  
  private let alreadyHaveAccountButton: UIButton = {
    let button = Utilities.shared.attibutedButton("Already have an account? ", "Login In")
    button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  // MARK: - Selectors
  
  @objc func handleAddPhoto() {
    print("Add photo")
  }
  @objc func handleSignUp() {
    print("DEBUG: Sign Up")
  }
  @objc func handleLogin() {
    navigationController?.popViewController(animated: true)
  }
  // MARK: - Helpers
  
  func configureUI() {
    view.backgroundColor = .twitterBlue
    passwordTextField.isSecureTextEntry = true
    let stack = UIStackView(arrangedSubviews: [plusPhotoButton, emailContainerView, passwordContainerView, fullnameContainerView, usernameContainerView, signupButton])
    stack.axis = .vertical
    stack.spacing = 20
    let margins = view.layoutMarginsGuide
    view.addSubview(stack)
    stack.anchor(top: margins.topAnchor, left: margins.leftAnchor, right: margins.rightAnchor)
    
    view.addSubview(alreadyHaveAccountButton)
    alreadyHaveAccountButton.anchor(left: margins.leftAnchor, bottom: margins.bottomAnchor, right: margins.rightAnchor)
  }
}
