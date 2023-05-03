import SwiftUI

struct TweetRowView: View {
    let tweet: Tweet
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 12.0) {
                AsyncImage(url: URL(string: tweet.profileImageUrl)) { image in
                    image.resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 56, height: 56)
                } placeholder: {
                    ProgressView()
                }
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(tweet.fullname)
                            .font(.subheadline).bold()
                        Text("@\(tweet.username)")
                            .foregroundColor(.gray)
                            .font(.caption)
                        Text("2w")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    Text(tweet.caption)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding(.horizontal)
            buttons
                .padding(.horizontal)
        }
    }
    let names = ["Reply", "Retweet", "React", "Share"]
    var buttons: some View {
        HStack {
            ForEach(names, id: \.self) { name in
                Button {
                    
                } label: {
                    Image(name)
                        .tint(.black)
                }
                if name != names.last {
                    Spacer()
                }
            }
        }
    }
}
