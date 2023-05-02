import SwiftUI

struct TweetRowView: View {
    let tweet: Tweet
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 12.0) {
                Circle()
                    .frame(width: 56, height: 56)
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Bruce Wayne")
                            .font(.subheadline).bold()
                        Text("@batman")
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

struct TweetRowView_Previews: PreviewProvider {
    static var previews: some View {
        TweetRowView(tweet: Tweet(caption: "this is my first tweet", uid: "", likes: 0))
    }
}
