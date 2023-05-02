import UIKit
import Kingfisher

final class AddTweetViewController: BaseViewController {
    private let store = AddTweetStore()
    private let cancelButton = UIButton(type: .system)
    private let saveButton = UIButton(type: .system)
    private let avatarView = UIImageView()
    private let textView = UITextView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
    }
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
        setupAvatarView()
        setupTextView()
    }
    
    private func setupCancelButton() {
        view.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(cancelButtonHandler), for: .primaryActionTriggered)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.tintColor = .systemBlue
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
    }
    
    private func setupSaveButton() {
        view.addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(saveButtonHandler), for: .primaryActionTriggered)
        saveButton.setTitle("Save", for: .normal)
        saveButton.tintColor = .systemBlue
        saveButton.snp.makeConstraints {
            $0.top.equalTo(cancelButton.snp.top)
            $0.right.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    private func setupAvatarView() {
        let radius = 18.5
        view.addSubview(avatarView)
        avatarView.kf.setImage(with: URL(string: PersonManager.shared.person.profileImageUrl))
        avatarView.contentMode = .scaleAspectFill
        avatarView.layer.cornerRadius = radius
        avatarView.layer.masksToBounds = true
        avatarView.snp.makeConstraints {
            $0.left.equalTo(cancelButton.snp.left)
            $0.top.equalTo(cancelButton.snp.bottom).offset(20)
            $0.width.equalTo(2 * radius)
            $0.height.equalTo(2 * radius)
        }
    }
    private func setupTextView() {
        view.addSubview(textView)
        
        textView.snp.makeConstraints {
            $0.top.equalTo(avatarView.snp.top)
            $0.left.equalTo(avatarView.snp.right).offset(20)
            $0.right.equalTo(saveButton.snp.right)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
    }
}
