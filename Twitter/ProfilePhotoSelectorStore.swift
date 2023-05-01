import UIKit
import FirebaseStorage
import FirebaseFirestore
import Firebase

enum ProfilePhotoSelectorEvent {
    case login
}

enum ProfilePhotoSelectorAction {
   case savePhoto(UIImage)
}

final class ProfilePhotoSelectorStore: Store<ProfilePhotoSelectorEvent, ProfilePhotoSelectorAction> {
    override func handleActions(action: ProfilePhotoSelectorAction) {
        switch action {
        case .savePhoto(let image):
            statefulCall {
                try await self.uploadImage(image: image)
            }
        }
    }
    
    func uploadImage(image: UIImage) async throws {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(fileName).jpg")
        let _ = try await ref.putDataAsync(imageData)
        let url = try await ref.downloadURL()
        let imageUrl = url.absoluteString
        guard let uid = Auth.auth().currentUser?.uid else { return }
        try await Firestore.firestore()
            .collection("persons")
            .document(uid)
            .updateData(["profileImageUrl": imageUrl])
        sendEvent(.login)
    }


}
