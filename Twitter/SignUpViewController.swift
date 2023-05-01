import SwiftUI

struct SignUpNavigation {
    let selectPhoto: Callback
}

final class SignUpViewController: BaseViewController {
    private let store = SignUpStore()
    private lazy var viewModel = SignUpViewModel(signup: {email, password, fullname, username in
        self.store.actions.send(.signUpWith(email, password, fullname, username))
    }, signin: {
        self.navigationController?.popViewController(animated: true)
    })
    private let navigation: SignUpNavigation
    private lazy var rootView: BridgedView = {
        SignUpView(viewModel: viewModel).bridge()
    }()
    
    init(navigation: SignUpNavigation) {
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
                case .selectPhoto:
                    self.navigation.selectPhoto()
                }
            }.store(in: &bag)
    }
}

extension SignUpViewController {
    override func setupViews() {
        super.setupViews()
        addIgnoringSafeArea(rootView)
        setupObservers()
    }
}
