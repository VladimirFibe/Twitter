import UIKit

final class MEditUsernameCell: BaseTableViewCell {
    static let identifier = "MEditUsernameCell"
    private let usernameTextField = UITextField()
    var text: String {
        usernameTextField.text ?? ""
    }
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
        usernameTextField.autocapitalizationType = .sentences
        usernameTextField.clearButtonMode = .whileEditing
        usernameTextField.enablesReturnKeyAutomatically = true
        usernameTextField.returnKeyType = .done
        usernameTextField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}
