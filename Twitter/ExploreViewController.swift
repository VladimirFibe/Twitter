import SwiftUI

final class ExploreViewController: BaseViewController {
    private lazy var rootView: BridgedView = {
        Text("Explore").bridge()
    }()
}

extension ExploreViewController {
    override func setupViews() {
        super.setupViews()
        addIgnoringSafeArea(rootView)
    }
}
