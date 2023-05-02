import FirebaseFirestoreSwift
import Firebase

struct Tweet: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    let caption: String
    var timestamp: Timestamp = Timestamp(date: Date())
    let uid: String
    var likes: Int
}
