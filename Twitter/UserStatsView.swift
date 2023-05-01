import SwiftUI

struct UserStatsView: View {
    var body: some View {
        HStack(spacing: 24) {
            ProfileStatisticView(value: 807, title: "Following")
            ProfileStatisticView(value: 20, title: "Followers")
        }
    }
}

struct ProfileStatisticView: View {
    let value: Int
    let title: String
    var body: some View {
        HStack(spacing: 4) {
            Text("\(value)")
                .font(.subheadline).bold()
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}
struct UserStatsView_Previews: PreviewProvider {
    static var previews: some View {
        UserStatsView()
    }
}
