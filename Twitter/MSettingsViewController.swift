import SwiftUI
import FirebaseAuth

enum SettingsCases: Int, CaseIterable {
    case profile
    case terms
    case logout
}

struct MSettingsNavigation {
    let editProfileHandle: Callback
}

final class MSettingsViewController: BaseViewController {
    private let navigation: MSettingsNavigation
    private let tableView = UITableView()
    
    init(navigation: MSettingsNavigation) {
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func currentSection(_ index: Int) -> SettingsCases {
        SettingsCases(rawValue: index) ?? .profile
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

extension MSettingsViewController {
    override func setupViews() {
        super.setupViews()
        title = "Settings"
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGray6
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
            cell.backgroundColor = .systemBackground
            return cell
        case .terms:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Terms", for: indexPath)
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = ["Tell a Friends", "Terms and Conditions"][indexPath.row]
            contentConfiguration.textProperties.color = .systemBlue
            cell.contentConfiguration = contentConfiguration
            cell.accessoryType = .disclosureIndicator
            cell.backgroundColor = .systemBackground
            return cell
        case .logout:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Logout", for: indexPath)
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = ["App version \((Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "")", "Log Out"][indexPath.row]
            contentConfiguration.textProperties.font = indexPath.row == 0 ? .systemFont(ofSize: 18) : .boldSystemFont(ofSize: 18)
            contentConfiguration.textProperties.color = indexPath.row == 0 ? .label : .systemRed
            contentConfiguration.textProperties.alignment = indexPath.row == 0 ? .justified : .center
            cell.contentConfiguration = contentConfiguration
            cell.backgroundColor = .systemBackground
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
        headerView.backgroundColor = .systemGray6
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch currentSection(indexPath.section) {
            
        case .profile:
            self.navigation.editProfileHandle()
        case .terms:
            print("terms")
        case .logout:
            if indexPath.row == 1 {
                do {
                    try Auth.auth().signOut()
                } catch {}
            }
        }
    }
}
