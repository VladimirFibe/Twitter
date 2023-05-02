import Foundation
import FirebaseAuth
import FirebaseFirestore

enum FeedEvent {
    case reload([Tweet])
}

enum FeedAction {
    case fetchTweets
}

final class FeedStore: Store<FeedEvent, FeedAction> {
    override func handleActions(action: FeedAction) {
        switch action {
        case .fetchTweets:
            statefulCall(fetchTweets)
        }
    }
    
    func fetchTweets() async throws {
        let snapshot = try await Firestore.firestore().collection("tweets").getDocuments()
        let tweets = snapshot.documents.compactMap { try? $0.data(as: Tweet.self)}
        try await PersonManager.shared.fetchPerson()
        sendEvent(.reload(tweets))
    }
}
