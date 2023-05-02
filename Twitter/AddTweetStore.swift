import Foundation
import FirebaseAuth
import FirebaseFirestore

enum AddTweetEvent {
    case dismiss
}

enum AddTweetAction {
    case uploadTweet(String)
}

final class AddTweetStore: Store<AddTweetEvent, AddTweetAction> {
    override func handleActions(action: AddTweetAction) {
        switch action {
        case .uploadTweet(let caption):
            statefulCall {
                try await self.uploadTweet(caption)
            }
        }
    }
    
    func uploadTweet(_ caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let data: [String: Any] = ["uid": uid,
                    "caption": caption,
                    "likes": 0,
                    "timestamp": Timestamp(date: Date())]
        try await Firestore.firestore().collection("tweets").document().setData(data)
        sendEvent(.dismiss)
    }
}
