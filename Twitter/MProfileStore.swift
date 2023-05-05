import UIKit
import FirebaseStorage
import FirebaseFirestore
import Firebase

enum MProfileEvent {
    case dismiss
}

enum MProfileAction {
   case save(UIImage?, String, String)
}

final class MProfileStore: Store<MProfileEvent, MProfileAction> {
    override func handleActions(action: MProfileAction) {
        switch action {
        case .save(let image, let status, let username):
            statefulCall {
                try await self.save(image: image, status: status, username: username)
            }
        }
    }
    
    func save(image: UIImage?, status: String, username: String) async throws {
        var data = ["username": username.lowercased(), "status": status]
        guard let uid = Auth.auth().currentUser?.uid else { return }
        if let image {
            let profileImageUrl = try await FileStorage.uploadImage(image, uid: uid)
            data["profileImageUrl"] = profileImageUrl
        }
        try await Firestore.firestore()
            .collection("persons")
            .document(uid)
            .updateData(data)
        try await fetchPerson()
        sendEvent(.dismiss)
    }
    
    private func fetchPerson() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("persons")
            .document(uid)
            .getDocument()
        guard let person = try? snapshot.data(as: Person.self) else { return}
        Person.currentPerson = person
    }
}
