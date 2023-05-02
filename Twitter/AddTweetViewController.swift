import UIKit

final class AddTweetViewController: BaseViewController {
    private let store = AddTweetStore()
    private let cancelButton = UIButton(type: .system)
    private let saveButton = UIButton(type: .system)
    private let textView = UITextView()
}

//MARK: - Actions
extension AddTweetViewController {
    @objc func cancelButtonHandler() {
        dismiss(animated: true)
    }
    
    @objc func saveButtonHandler() {
        guard let caption = textView.text, !caption.isEmpty else { return }
        store.actions.send(.uploadTweet(caption))
    }
    
    private func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .dismiss: self.dismiss(animated: true)
                }
            }.store(in: &bag)
    }
}

//MARK: - Setup Views
extension AddTweetViewController {
    override func setupViews() {
        super.setupViews()
        setupObservers()
        setupCancelButton()
        setupSaveButton()
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
    
    private func setupSaveButton() {
        view.addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(saveButtonHandler), for: .primaryActionTriggered)
        saveButton.setTitle("Save", for: .normal)
        saveButton.tintColor = .systemBlue
        saveButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    private func setupTextView() {
        view.addSubview(textView)
        textView.snp.makeConstraints {
            $0.top.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(100)
            $0.left.equalToSuperview().offset(100)
        }
    }
}
