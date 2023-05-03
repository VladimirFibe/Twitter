import SwiftUI

final class NotificationsViewController: BaseViewController {
    private lazy var rootView: BridgedView = {
        ProfileView(PersonManager.shared.person).bridge()
    }()
}

extension NotificationsViewController {
    override func setupViews() {
        super.setupViews()
        addIgnoringSafeArea(rootView)
    }
}
