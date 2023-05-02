import Foundation
import FirebaseAuth
import FirebaseFirestore

enum ExploreEvent {
    case reload([Person])
}

enum ExploreAction {
    case fetchPerson
}

final class ExploreStore: Store<ExploreEvent, ExploreAction> {
    override func handleActions(action: ExploreAction) {
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
