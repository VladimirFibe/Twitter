import UIKit

final class MProfileViewController: BaseViewController {
    private let tableView = UITableView()
}

extension MProfileViewController {
    override func navBarLeftButtonHandler() {
        navigationController?.popViewController(animated: true)
    }
}

extension MProfileViewController {
    override func setupViews() {
        super.setupViews()
        title = "EditProfile"
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MEditProfileCell.self, forCellReuseIdentifier: MEditProfileCell.identifier)
        tableView.register(MEditUsernameCell.self, forCellReuseIdentifier: MEditUsernameCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Status")
        tableView.sectionHeaderTopPadding = 0
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension MProfileViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
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
}

extension MProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MEditProfileCell.identifier, for: indexPath) as? MEditProfileCell else { return UITableViewCell()}
                if let person = Person.currentPerson {
                    cell.configure(with: person)
                }
                cell.backgroundColor = .systemBackground
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MEditUsernameCell.identifier, for: indexPath) as? MEditUsernameCell else { return UITableViewCell()}
                if let person = Person.currentPerson {
                    cell.configure(with: person)
                }
                cell.backgroundColor = .systemBackground
                return cell
            }
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Status", for: indexPath)
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = "At the Movie"
            cell.contentConfiguration = contentConfiguration
            cell.backgroundColor = .systemBackground
            return cell
        }
    }
    
    
}
