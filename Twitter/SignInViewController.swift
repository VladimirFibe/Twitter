import SwiftUI

final class SignInViewController: BaseViewController {
    private lazy var rootView: BridgedView = {
        SignInView().bridge()
    }()
    
}

extension SignInViewController {
    override func setupViews() {
        super.setupViews()
        addIgnoringSafeArea(rootView)
    }
}
