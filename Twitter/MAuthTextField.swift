import UIKit

final class MAuthTextField: BaseView {
    private let spacing = 16.0
    private let titleLabel = UILabel()
    private let textField = UITextField()
    private let dividerView = UIView()
    
    func configure(with title: String,
                   isSecureTextEntry: Bool = false) {
        titleLabel.text = title
        textField.placeholder = title
        textField.isSecureTextEntry = isSecureTextEntry
    }
}

extension MAuthTextField {
    @objc func textFieldDidChanged() {
        titleLabel.isHidden = textField.text?.isEmpty != false
    }
}

extension MAuthTextField {
    override func setupViews() {
        setupTitleLable()
        setupTextField()
        setupDividerView()
        setupTextFieldDelegate()
    }
    
    private func setupTitleLable() {
        addSubview(titleLabel)
        titleLabel.font = .avenirBook(size: 20)
        titleLabel.textColor = .lightGray
        titleLabel.isHidden = true
        titleLabel.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
        }
    }
    
    private func setupTextField() {
        addSubview(textField)
        textField.borderStyle = .none
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(spacing)
            $0.left.right.equalTo(titleLabel)
        }
    }
    
    private func setupDividerView() {
        addSubview(dividerView)
        dividerView.backgroundColor = .systemGray
        dividerView.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.top.equalTo(textField.snp.bottom).offset(spacing)
            $0.left.right.equalTo(titleLabel)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setupTextFieldDelegate() {
        textField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
}
