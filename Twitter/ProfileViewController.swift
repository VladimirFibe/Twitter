import SwiftUI

struct ProfileNavigation {
    let logoutHandler: Callback
    let menuHandler: Callback
}

final class ProfileViewController: BaseViewController {
    private let navigation: ProfileNavigation
    
    private lazy var rootView: BridgedView = {
        ProfileView(PersonManager.shared.person).bridge()
    }()
    
    init(navigation: ProfileNavigation) {
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileViewController {
    override func setupViews() {
        super.setupViews()
        addIgnoringSafeArea(rootView)
    }
}
