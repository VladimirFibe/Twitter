import Foundation
import Firebase
import FirebaseFirestoreSwift

final class PersonManager {
    static let shared = PersonManager()
    private init() {}
    
    var person = Person(fullname: "", username: "", email: "", profileImageUrl: "")
    
    func fetchPerson() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("persons")
            .document(uid)
            .getDocument()
        guard let person = try? snapshot.data(as: Person.self) else { return }
        self.person = person
    }
}
