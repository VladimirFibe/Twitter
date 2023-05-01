import SwiftUI
import PhotosUI

struct ProfilePhotoSelectorNavigation {
    let login: Callback
}
final class ProfilePhotoSelectorViewController: BaseViewController {
    private var navigation: ProfilePhotoSelectorNavigation
    private let store = ProfilePhotoSelectorStore()
    private lazy var viewModel = ProfilePhotoSelectorViewModel(presentPicker: presentPicker) { image in
        self.store.actions.send(.savePhoto(image))
    }
    private lazy var rootView: BridgedView = {
        ProfilePhotoSelectorView(viewModel: viewModel).bridge()
    }()
    
    init(navigation: ProfilePhotoSelectorNavigation) {
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self else { return }
                switch event {
                case .login: self.navigation.login()
                }
            }.store(in: &bag)
    }
    
    private func presentPicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension ProfilePhotoSelectorViewController {
    override func setupViews() {
        super.setupViews()
        addIgnoringSafeArea(rootView)
        setupObservers()
    }
}

extension ProfilePhotoSelectorViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    let image = image as? UIImage
                    self?.viewModel.loadImage(image)
                }
            }
        }
    }
}
