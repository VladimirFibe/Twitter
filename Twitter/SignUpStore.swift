import Foundation
import FirebaseAuth
import FirebaseFirestore

enum SignUpEvent {
    case selectPhoto
}

enum SignUpAction {
   case signUpWith(String, String, String, String)
}

final class SignUpStore: Store<SignUpEvent, SignUpAction> {
    override func handleActions(action: SignUpAction) {
        switch action {
        case .signUpWith(let email, let password, let fullname, let username):
            statefulCall {
                try await self.signUpWith(email: email, password: password, fullname: fullname, username: username)
            }
        }
    }
    
    func signUpWith(email: String, password: String, fullname: String, username: String) async throws {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let uid = authResult.user.uid
        let data: [String: Any] = [
            "email": email,
            "username": username.lowercased(),
            "fullname": fullname,
            "uid": uid]
        try await Firestore.firestore().collection("persons").document(uid).setData(data)
        sendEvent(.selectPhoto)
    }
}
