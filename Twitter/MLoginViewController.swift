import UIKit
import Firebase

enum MLoginType {
    case login
    case registration
    case password
}

struct MLoginNavigation {
    let login: Callback
}

final class MLoginViewController: BaseViewController {
    private let navigation: MLoginNavigation
    private let store = MLoginStore()
    private var isLogin = true {  didSet { updateUI() }}
    private let loginLabel = UILabel()
    private let emailField = MAuthTextField()
    private let passwordField = MAuthTextField()
    private let repeatPasswordField = MAuthTextField()
    private lazy var stack = UIStackView(
        arrangedSubviews: [emailField, passwordField, repeatPasswordField])
    private let forgotPasswordButton = UIButton(type: .system)
    private let resendEmailButton = UIButton(type: .system)
    private let loginButton = UIButton(type: .system)
    private let bottomLabel = UILabel()
    private let bottomButton = UIButton(type: .system)
    private lazy var bottomStack = UIStackView(arrangedSubviews: [bottomLabel, bottomButton])
    
    init(navigation: MLoginNavigation) {
            self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .login:
                    self.navigation.login()
                case .linkForResetPasswordSended:
                    ProgressHUD.showSucceed("Check \(emailField.text) for reset password link")
                case .linkForVerifySended:
                    ProgressHUD.showSucceed("Check \(emailField.text) for verification link")
                    resendEmailButton.isHidden = false
                    isLogin = true
                case .notVerifiedEmail:
                    ProgressHUD.showFailed("Please verify email.")
                    resendEmailButton.isHidden = false
                }
            }.store(in: &bag)
    }
}

//MARK: - Actions
extension MLoginViewController {
    @objc func loginButtonHandle() {
        if isDataInputed(for: isLogin ? .login : .registration) {
            if isLogin {
                store.actions.send(.signInWith(emailField.text, passwordField.text))
            } else {
                store.actions.send(.signUpWith(emailField.text, passwordField.text))
            }
        } else {
            ProgressHUD.showFailed("All Fields are required")
        }
    }
    
    @objc func forgotButtonHandle() {
        if isDataInputed(for: .password) {
            store.actions.send(.sendPasswordReset(emailField.text))
        } else {
            ProgressHUD.showFailed("Email is required")
        }
    }
    
    @objc func resendButtonHandle() {
        store.actions.send(.sendEmailVerification)
    }
    
    @objc func bottomButtonHandle() {
        isLogin.toggle()
    }
    
    private func updateUI() {
        loginButton.setImage(UIImage(named: isLogin ? "loginBtn" : "registerBtn")?
            .withRenderingMode(.alwaysOriginal), for: .normal)
        bottomButton.setTitle(isLogin ? "Sign Up" : "Login", for: .normal)
        bottomLabel.text = isLogin ? "Don't have an account?" : "Have an account?"
        
        UIView.animate(withDuration: 0.5) {
            self.repeatPasswordField.isHidden = self.isLogin
        }
    }
    
    @objc func backgroundTapHandle() {
        view.endEditing(false)
    }
    
    private func isDataInputed(for type: MLoginType) -> Bool {
        switch type {
            
        case .login:
            return emailField.isValid && passwordField.isValid
        case .registration:
            return emailField.isValid && passwordField.isValid && passwordField.text == repeatPasswordField.text
        case .password:
            return emailField.isValid
        }
    }
}

//MARK: - Setup Views
extension MLoginViewController {
    override func setupViews() {
        super.setupViews()
        setupObservers()
        setupLoginLabel()
        setupFieldStack()
        setupEmailField()
        setupPasswordField()
        setupRepeatPasswordField()
        setupForgotPasswordButton()
        setupResendEmailButton()
        setupLoginButton()
        setupBottomStack()
        setupBottomLabel()
        setupBottomButton()
        setupBackgroundTap()
        updateUI()
    }
    
    private func setupLoginLabel() {
        view.addSubview(loginLabel)
        loginLabel.text = "Login"
        loginLabel.font = .avenirBook(size: 35) //UIFont(name: "Avenir-Book", size: 35)
        loginLabel.textAlignment = .center
        loginLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
        }
    }
    
    private func setupFieldStack() {
        view.addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 16
        stack.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(10)
            $0.left.right.equalTo(loginLabel).inset(16)
        }
        
    }
    private func printFonts() {
        for family in UIFont.familyNames.sorted() {
          let names = UIFont.fontNames(forFamilyName: family)
          print(family, names)
        }
    }
    
    private func setupEmailField() {
        emailField.configure(with: "Email")
        
    }
    
    private func setupPasswordField() {
        passwordField.configure(with: "Password",
                                isSecureTextEntry: true)
    }
    
    private func setupRepeatPasswordField() {
        repeatPasswordField.configure(with: "Repeat Password",
                                      isSecureTextEntry: true)
    }
    
    private func setupForgotPasswordButton() {
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
        forgotPasswordButton.tintColor = .darkGray
        forgotPasswordButton.titleLabel?.textAlignment = .left
        forgotPasswordButton.addTarget(self, action: #selector(forgotButtonHandle), for: .primaryActionTriggered)
        forgotPasswordButton.snp.makeConstraints {
            $0.top.equalTo(stack.snp.bottom).offset(10)
            $0.left.equalTo(stack.snp.left)
        }
    }
    
    private func setupResendEmailButton() {
        view.addSubview(resendEmailButton)
        resendEmailButton.setTitle("Resend Email?", for: .normal)
        resendEmailButton.tintColor = .darkGray
        resendEmailButton.titleLabel?.textAlignment = .right
        resendEmailButton.addTarget(self, action: #selector(resendButtonHandle), for: .primaryActionTriggered)
        resendEmailButton.isHidden = true
        resendEmailButton.snp.makeConstraints {
            $0.top.equalTo(stack.snp.bottom).offset(10)
            $0.right.equalTo(stack.snp.right)
        }
    }
    
    private func setupLoginButton() {
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(loginButtonHandle), for: .primaryActionTriggered)
        loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(forgotPasswordButton.snp.bottom).offset(20)
        }
    }
    
    private func setupBottomLabel() {
        bottomLabel.font = .avenirBook(size: 16)
    }
    
    private func setupBottomButton() {
        bottomButton.addTarget(self, action: #selector(bottomButtonHandle), for: .primaryActionTriggered)
    }
    
    private func setupBottomStack() {
        view.addSubview(bottomStack)
        bottomStack.spacing = 10
        bottomStack.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapHandle))
        view.addGestureRecognizer(tapGesture)
    }
}
