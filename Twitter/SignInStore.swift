import Foundation
import FirebaseAuth
import FirebaseFirestore

enum SignInEvent {
    case login
}

enum SignInAction {
   case signInWith(String, String)
}

final class SignInStore: Store<SignInEvent, SignInAction> {
    override func handleActions(action: SignInAction) {
        switch action {
        case .signInWith(let email, let password):
            statefulCall {
                try await self.signIn(withEmail: email, password: password)
            }
        }
    }
    
    func signIn(withEmail email: String, password: String) async throws {
        let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
        sendEvent(.login)
    }

}
