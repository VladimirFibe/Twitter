import FirebaseFirestoreSwift

struct Person: Identifiable, Codable {
    @DocumentID var id: String?
    let fullname: String
    let username: String
    let email: String
    let profileImageUrl: String
}
