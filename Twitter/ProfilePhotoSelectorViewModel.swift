import SwiftUI

final class ProfilePhotoSelectorViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var profileImage: Image?

    let presentPicker: Callback
    let savePhoto: (UIImage) -> ()
    
    init(presentPicker: @escaping Callback,
         savePhoto: @escaping (UIImage) -> ()) {
        self.presentPicker = presentPicker
        self.savePhoto = savePhoto
    }
    
    func loadImage(_ image: UIImage?) {
        selectedImage = image
        guard let selectedImage else { return }
        profileImage = Image(uiImage: selectedImage)
    }
    
    func saveImage() {
        guard let selectedImage else { return }
        savePhoto(selectedImage)
    }
}
