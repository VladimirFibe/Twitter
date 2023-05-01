import SwiftUI

class MenuViewController: UIViewController {
    
    private lazy var rootView: BridgedView = {
        SideMenuView().bridge()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        addIgnoringSafeArea(rootView)
    }
}
