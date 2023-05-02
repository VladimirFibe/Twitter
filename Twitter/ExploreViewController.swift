import SwiftUI

enum ExploreSection: Hashable {
    case main
}

final class ExploreViewController: BaseViewController {
    private let store = ExploreStore()
    private var persons: [Person] = []
    private let tableView = UITableView()
    
    private func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case let .reload(persons):
                    self.persons = persons
                    configureInitialDiffableSnapshot()
                }
            }.store(in: &bag)
    }
    
    private lazy var dataSource: UITableViewDiffableDataSource<ExploreSection, Person> = {
        let dataSource = UITableViewDiffableDataSource<ExploreSection, Person>(tableView: tableView) { tableView, indexPath, person in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreCell", for: indexPath)
            cell.contentConfiguration = UIHostingConfiguration {
                PersonRowView(person: person)
            }
            return cell
        }
        return dataSource
    }()
    
    func configureInitialDiffableSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<ExploreSection, Person>()
        snapshot.appendSections([.main])
        snapshot.appendItems(persons)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension ExploreViewController {
    override func setupViews() {
        super.setupViews()
        setupTableView()
        setupObservers()
        store.actions.send(.fetchPerson)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ExploreCell")
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
