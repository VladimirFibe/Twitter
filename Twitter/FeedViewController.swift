import SwiftUI

struct FeedNavigation {
    let addTweetHandle: Callback
}

final class FeedViewController: BaseViewController {
    private let navigation: FeedNavigation
    private let store = FeedStore()
    private let addTweetButton = UIButton()
    
    init(navigation: FeedNavigation) {
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Actions
extension FeedViewController {
    @objc func addTweetHandle() {
        navigation.addTweetHandle()
    }
}

//MARK: - Setup Views
extension FeedViewController {
    override func setupViews() {
        super.setupViews()
        setupAddTweetButton()
    }
    
    func setupAddTweetButton() {
        view.addSubview(addTweetButton)
        addTweetButton.setImage(UIImage(named: "AddTweet"), for: .normal)
        addTweetButton.addTarget(self, action: #selector(addTweetHandle), for: .primaryActionTriggered)
        addTweetButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}
