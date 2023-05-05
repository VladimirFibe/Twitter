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
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let profileImageUrl = try await FileStorage.uploadImage(image, uid: uid)
        try await Firestore.firestore()
            .collection("persons")
            .document(uid)
            .updateData(["profileImageUrl": profileImageUrl])
        sendEvent(.login)
    }
}
