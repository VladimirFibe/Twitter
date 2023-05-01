import Foundation

enum TabItem: Int {
    case feed
    case search
    case notifications
    case messages
    
    var icon: String {
        switch self {
        case .feed: return "Home"
        case .search:  return "Search"
        case .notifications: return "Notifications"
        case .messages: return "Messages"
        }
    }
    
    var iconFill: String {
        switch self {
        case .feed: return "Home-Fill"
        case .search:  return "Search"
        case .notifications: return "Notifications-Fill"
        case .messages: return "Messages-Fill"
        }
    }
}
