import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Person: Identifiable, Codable, Hashable, Equatable {
    @DocumentID var id: String?
    let fullname: String
    let username: String
    let email: String
    let profileImageUrl: String
    
    enum CodingKeys: CodingKey {
        case fullname
        case username
        case email
        case profileImageUrl
    }
    
    static var currentUid: String? {
        Auth.auth().currentUser?.uid
    }
    
    static var currentPerson: Person? {
        get {
            if let data = UserDefaults.standard.value(forKey: "currentPerson") as? Data {
                let decoder = JSONDecoder()
                return try? decoder.decode(Person.self, from: data)
            } else {
                return nil
            }
        }
        set {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(newValue) {
                UserDefaults.standard.set(data, forKey: "currentPerson")
            }
        }
    }
}
