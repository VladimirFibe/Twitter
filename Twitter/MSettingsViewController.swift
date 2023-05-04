import SwiftUI
enum SettingsCases: Int, CaseIterable {
    case profile
    case terms
    case logout
}
final class MSettingsViewController: BaseViewController {

    private let tableView = UITableView()
    func currentSection(_ index: Int) -> SettingsCases {
        SettingsCases(rawValue: index) ?? .profile
    }
}

extension MSettingsViewController {
    override func setupViews() {
        super.setupViews()
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(MSettignsProfileCell.self, forCellReuseIdentifier: MSettignsProfileCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Terms")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Logout")
        tableView.sectionHeaderTopPadding = 0
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension MSettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        SettingsCases.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch currentSection(indexPath.section) {
        case .profile:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MSettignsProfileCell.identifier, for: indexPath) as? MSettignsProfileCell else { return UITableViewCell()}
            if let person = Person.currentPerson {
                cell.configure(with: person)
                cell.accessoryType = .disclosureIndicator
            }
            return cell
        case .terms:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Terms", for: indexPath)
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = "text"
            cell.contentConfiguration = contentConfiguration
            cell.accessoryType = .disclosureIndicator
            return cell
        case .logout:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Logout", for: indexPath)
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = "text"
            cell.contentConfiguration = contentConfiguration
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
}

extension MSettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? 0.0 : 10.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .red
        return headerView
    }
}
