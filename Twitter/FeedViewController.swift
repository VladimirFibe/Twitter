import SwiftUI

enum FeedSection: Hashable {
    case main
}

struct FeedNavigation {
    let addTweetHandle: Callback
    let menuHandle: Callback
}

final class FeedViewController: BaseViewController {
    private let navigation: FeedNavigation
    private let store = FeedStore()
    private var tweets: [Tweet] = []
    
    private let tableView = UITableView()
    private let addTweetButton = UIButton()
    
    init(navigation: FeedNavigation) {
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
                case let .reload(tweets):
                    self.tweets = tweets
                    configureInitialDiffableSnapshot()
                }
            }.store(in: &bag)
    }
    
    private lazy var dataSource: UITableViewDiffableDataSource<FeedSection, Tweet> = {
        let dataSource = UITableViewDiffableDataSource<FeedSection, Tweet>(tableView: tableView) { tableView, indexPath, tweet in
            let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath)
            cell.contentConfiguration = UIHostingConfiguration {
                TweetRowView(tweet: tweet)
            }
            return cell
        }
        return dataSource
    }()
    
    func configureInitialDiffableSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<FeedSection, Tweet>()
        snapshot.appendSections([.main])
        snapshot.appendItems(tweets)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.actions.send(.fetchTweets)
    }
}

//MARK: - Actions
extension FeedViewController {
    @objc func addTweetHandle() {
        navigation.addTweetHandle()
    }
    
    override func navBarLeftButtonHandler() {
        navigation.menuHandle()
    }
}

//MARK: - Setup Views
extension FeedViewController {
    override func setupViews() {
        super.setupViews()
        setupTableView()
        setupAddTweetButton()
        setupObservers()
        addNavBarButton(at: .left)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TweetCell")
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
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
