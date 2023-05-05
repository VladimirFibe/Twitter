import UIKit
import PhotosUI
import FirebaseFirestore
import Firebase

struct MEditProfileNavigation {
    let selectStatusHandle: (Status) -> ()
}

final class MProfileViewController: BaseViewController {
    private let navigation: MEditProfileNavigation
    private var status = Status.Available
    private var avatar: UIImage?
    private let tableView = UITableView()
    private let usernameCell = MEditUsernameCell()
    private let headerCell = MEditProfileCell()
    init(navigation: MEditProfileNavigation) {
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MProfileViewController {
    override func navBarLeftButtonHandler() {
        navigationController?.popViewController(animated: true)
    }
    
    override func navBarRightButtonHandler() {
        var data = ["username": usernameCell.text.lowercased(),
                    "status": status.rawValue]
        guard let uid = Person.currentUid else { return }
        if let avatar {
            FileStorage.uploadImage(avatar, uid: uid) { link in
                if let link {
                    data["profileImageUrl"] = link
                    self.save(data: data, uid: uid)
                }
            }
        } else {
            save(data: data, uid: uid)
        }
        
    }
    
    func save(data: [String: String], uid: String) {
        Firestore.firestore()
            .collection("persons")
            .document(uid)
            .updateData(data) { _ in
                Firestore.firestore().collection("persons")
                    .document(uid)
                    .getDocument { snapshot, _ in
                        Person.currentPerson = try? snapshot?.data(as: Person.self)
                        self.navigationController?.popViewController(animated: true)
                    }
            }
    }
    
    @objc func editButtonHadle() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension MProfileViewController {
    override func setupViews() {
        super.setupViews()
        title = "Edit Profile"
        setupTableView()
        setupUsernameField()
        addNavBarButton(at: .right, with: "Save")
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
    
    private func setupUsernameField() {
        if let person = Person.currentPerson {
            usernameCell.configure(with: person)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            self.navigation.selectStatusHandle(status)
        }
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
                let cell = headerCell
                if let person = Person.currentPerson {
                    cell.configure(with: person,
                                   target: self,
                                   action: #selector(editButtonHadle),
                                   avatar: self.avatar)
                }
                return cell
            } else {
                let cell = usernameCell
                return cell
            }
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Status", for: indexPath)
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = status.rawValue
            cell.contentConfiguration = contentConfiguration
            cell.backgroundColor = .systemBackground
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
}

extension MProfileViewController: MStatusProtocol {
    func configure(with status: Status) {
        self.status = status
        self.tableView.reloadData()
    }
}

extension MProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        if let itemProvider = results.first?.itemProvider,
            itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let image = image as? UIImage else {
                        ProgressHUD.showError("Couldn't select image!")
                        return }
                    self?.avatar = image
                    self?.headerCell.configure(withImage: image)
                }
            }
        }
    }
}
