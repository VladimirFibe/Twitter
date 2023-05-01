import SwiftUI

final class MessagesViewController: BaseViewController {
    private lazy var rootView: BridgedView = {
        Text("Messages").bridge()
    }()
}

extension MessagesViewController {
    override func setupViews() {
        super.setupViews()
        addIgnoringSafeArea(rootView)
    }
}
