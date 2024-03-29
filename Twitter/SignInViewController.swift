import SwiftUI

struct SignInNavigation {
    let signupHandler: Callback
    let signInHadler: Callback
}

final class SignInViewController: BaseViewController {
    private var navigation: SignInNavigation
    private lazy var viewModel = SingInViewModel(signup: navigation.signupHandler) { email, password in
        self.store.actions.send(.signInWith(email, password))
    }
    private let store = SignInStore()
    private lazy var rootView: BridgedView = {
        SignInView(viewModel: viewModel).bridge()
    }()
    
    init(navigation: SignInNavigation) {
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
                    self.navigation.signInHadler()
                }
            }.store(in: &bag)
    }
}

extension SignInViewController {
    override func setupViews() {
        super.setupViews()
        addIgnoringSafeArea(rootView)
        setupObservers()
    }
}
