import FirebaseFirestoreSwift
import Firebase

struct Tweet: Identifiable, Decodable, Hashable {
    @DocumentID var id: String?
    let caption: String
    var timestamp: Timestamp = Timestamp(date: Date())
    let uid: String
    var likes = 0
    var fullname = ""
    var username = ""
    var profileImageUrl = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case caption
        case timestamp
        case uid
        case likes
    }
}
