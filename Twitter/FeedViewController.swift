import SwiftUI

final class FeedViewController: BaseViewController {
    private lazy var rootView: BridgedView = {
        Text("Feed").bridge()
    }()
}

extension FeedViewController {
    override func setupViews() {
        super.setupViews()
        addIgnoringSafeArea(rootView)
    }
}
