import Foundation
import FirebaseAuth
import FirebaseFirestore

enum FeedEvent {
    case reload([Person])
}

enum FeedAction {
    case fetchPerson
}

final class FeedStore: Store<FeedEvent, FeedAction> {
    override func handleActions(action: FeedAction) {
        switch action {
        case .fetchPerson:
            statefulCall(fetchPersons)
        }
    }
    
    func fetchPersons() async throws {
        let snapshot = try await Firestore.firestore().collection("persons").getDocuments()
        let persons = snapshot.documents.compactMap { try? $0.data(as: Person.self)}
        sendEvent(.reload(persons))
    }
}
