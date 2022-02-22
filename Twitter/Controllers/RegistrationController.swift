//
//  RegistrationController.swift
//  Twitter
//
//  Created by Vladimir Fibe on 21.02.2022.
//

import UIKit
import Firebase
import FirebaseDatabase
class RegistrationController: UIViewController {
  // MARK: - Properties
  
  private var profileImage: UIImage?
  private let imagePicker = UIImagePickerController()
  
  private let plusPhotoButton: UIButton = {
    let button = UIButton(type: .system)
    let profileImageSize = 128.0
    button.setImage(UIImage(named: "photo"), for: .normal)
    button.tintColor = .white
    button.setDimensions(width: profileImageSize, height: profileImageSize)
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
    present(imagePicker, animated: true, completion: nil)
  }
  @objc func handleSignUp() {
    guard let profileImage = profileImage else { return }
    guard let email = emailTextField.text else { return }
    guard let password = passwordTextField.text else { return }
    guard let fullname = fullnameTextField.text else { return }
    guard let username = usernameTextField.text else { return }
    guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
    let credentials = AuthCredentials(email: email, password: password, fullname: fullname, username: username, imageData: imageData)
    AuthService.shared.registerUser(credentials: credentials) { error, reference in
      guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow}) else { return }
      guard let controller = window.rootViewController as? MainTabController else { return }
      controller.authenticateUserAndConfigureUI()
      self.dismiss(animated: true, completion: nil)
    }
  }
  @objc func handleLogin() {
    navigationController?.popViewController(animated: true)
  }
  // MARK: - Helpers
  
  func configureUI() {
    view.backgroundColor = .twitterBlue
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    
    passwordTextField.isSecureTextEntry = true
    
    view.addSubview(plusPhotoButton)
    plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
    let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullnameContainerView, usernameContainerView, signupButton])
    stack.axis = .vertical
    stack.spacing = 20
    let margins = view.layoutMarginsGuide
    view.addSubview(stack)
    stack.anchor(top: plusPhotoButton.bottomAnchor, left: margins.leftAnchor, right: margins.rightAnchor, paddingTop: 20)
    
    view.addSubview(alreadyHaveAccountButton)
    alreadyHaveAccountButton.anchor(left: margins.leftAnchor, bottom: margins.bottomAnchor, right: margins.rightAnchor)
  }
}

// MARK: - UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let profileImage = info[.editedImage] as? UIImage else { return }
    self.profileImage = profileImage
    plusPhotoButton.layer.cornerRadius = 64
    plusPhotoButton.layer.masksToBounds = true
    plusPhotoButton.imageView?.contentMode = .scaleAspectFill
    plusPhotoButton.imageView?.clipsToBounds = true
    plusPhotoButton.layer.borderColor = UIColor.white.cgColor
    plusPhotoButton.layer.borderWidth = 3
    plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
    dismiss(animated: true, completion: nil)
  }
}
