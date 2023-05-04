import UIKit

final class MEditUsernameCell: BaseTableViewCell {
    static let identifier = "MEditUsernameCell"
    private let usernameTextField = UITextField()
    func configure(with person: Person) {
        usernameTextField.text = person.username
    }
}

extension MEditUsernameCell {
    override func setupViews() {
        setupUsernameTextField()
    }
    
    private func setupUsernameTextField() {
        contentView.addSubview(usernameTextField)
        usernameTextField.placeholder = "username"
        usernameTextField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}
