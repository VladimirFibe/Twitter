import UIKit

protocol MStatusProtocol: AnyObject {
    func configure(with status: Status)
}
final class MStatusViewController: BaseViewController {
    private var status: Status
    var allStatuses = Status.allCases
    weak var delegate: MStatusProtocol?
    private let tableView = UITableView()
    
    init(status: Status) {
        self.status = status
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MStatusViewController {
    override func setupViews() {
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "StatusCell")
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension MStatusViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.configure(with: allStatuses[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}

extension MStatusViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allStatuses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatusCell", for: indexPath)
        let status = allStatuses[indexPath.row]
        cell.textLabel?.text = status.rawValue
        cell.accessoryType = self.status == status ? .checkmark : .none
        return cell
    }
}
