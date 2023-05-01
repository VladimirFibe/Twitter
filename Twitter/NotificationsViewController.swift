import SwiftUI

final class NotificationsViewController: BaseViewController {
    private lazy var rootView: BridgedView = {
        Text("Notifications").bridge()
    }()
}

extension NotificationsViewController {
    override func setupViews() {
        super.setupViews()
        addIgnoringSafeArea(rootView)
    }
}
