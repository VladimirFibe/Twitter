import UIKit

final class AddTweetViewController: BaseViewController {
    private let cancelButton = UIButton(type: .system)
    private let textView = UITextView()
}

//MARK: - Actions
extension AddTweetViewController {
    @objc func cancelButtonHandler() {
        dismiss(animated: true)
    }
}
//MARK: - Setup Views
extension AddTweetViewController {
    override func setupViews() {
        super.setupViews()
        setupCancelButton()
        setupTextView()
    }
    
    private func setupCancelButton() {
        view.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(cancelButtonHandler), for: .primaryActionTriggered)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.tintColor = .systemBlue
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
    }
    
    private func setupTextView() {
        view.addSubview(textView)
        textView.snp.makeConstraints {
            $0.top.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.left.equalToSuperview().offset(100)
        }
    }
}
