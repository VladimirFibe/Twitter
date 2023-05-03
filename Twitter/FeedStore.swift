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
        let snapshot = try await Firestore.firestore().collection("tweets")
            .order(by: "timestamp", descending: true)
            .getDocuments()
        var tweets = snapshot.documents.compactMap { try? $0.data(as: Tweet.self)}
        try await PersonManager.shared.fetchPerson()
        for i in 0..<tweets.count {
            let snapshot = try await Firestore.firestore().collection("persons").document(tweets[i].uid)
                .getDocument()
            if let person = try? snapshot.data(as: Person.self) {
                tweets[i].fullname = person.fullname
                tweets[i].username = person.username
                tweets[i].profileImageUrl = person.profileImageUrl
            }
        }
        sendEvent(.reload(tweets))
    }
}
