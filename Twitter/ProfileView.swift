import SwiftUI
import Firebase

struct ProfileView: View {
    let action: Callback
    var body: some View {
        VStack {
            Button {
                do {
                    try Auth.auth().signOut()
                    action()
                } catch {}
            } label: {
                Text("Logout")
            }
        }

    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView {}
    }
}
