import SwiftUI

struct SideMenuView: View {
    let person = Person(fullname: "Vladimir Fibe", username: "macuser", email: "vladimir@fibeapp.ru", profileImageUrl: "https://avatarko.ru/img/kartinka/1/ohapka_deneg.jpg")
    var flag = true
    var body: some View {
        VStack(alignment: .leading, spacing: 32.0) {
            header
            menulist
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
//        .frame(width: 300)
    }
    
    var menulist: some View {
        ForEach(SideMenuViewModel.allCases) { row in
            if row == .profile {
                Button(action: {}) {
                    SideMenuRowView(row: row)
                }
            } else if row == .logout {
                Button {
                    
                } label: {
                    SideMenuRowView(row: row)
                }

            } else {
                SideMenuRowView(row: row)
            }
        }
    }
    var header: some View {
        VStack(alignment: .leading) {
            if flag {
                AsyncImage(url: URL(string: person.profileImageUrl)) { image in
                    image.resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 4.0) {
                    Text(person.fullname)
                        .font(.headline)
                    Text("@\(person.username)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                UserStatsView().padding(.vertical)
            }
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
