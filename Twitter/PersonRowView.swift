import SwiftUI

struct PersonRowView: View {
    let person: Person
    var body: some View {
        HStack(spacing: 12.0) {
            AsyncImage(url: URL(string: person.profileImageUrl), content: { image in
                image.resizable()
                    .scaledToFill()
                    .clipShape(Circle())
            }, placeholder: {
                ProgressView()
            })
                .frame(width: 56, height: 56)
            VStack(alignment: .leading, spacing: 4.0) {
                Text(person.username)
                    .bold()
                Text(person.fullname)
                    .foregroundColor(.gray)
            }
            .font(.subheadline)
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

struct PersonRowView_Previews: PreviewProvider {
    static var previews: some View {
        PersonRowView(person: Person(id: "", fullname: "Vladimir Fibe", username: "macuser", email: "email@email", profileImageUrl: "https://firebasestorage.googleapis.com/v0/b/tweet-8c363.appspot.com/o/profile_image%2F311814767_866708774757315_3286012886601117381_n.jpg?alt=media&token=23ad9506-0dd5-4cfe-87ea-53f46213960e"))
    }
}
