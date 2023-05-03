import Foundation

enum TweetFilterViewModel: String, Identifiable, CaseIterable {
    case tweets = "Tweets"
    case replies = "Replies"
    case likes = "Likes"
    
    var id: String {
        self.rawValue
    }
}
