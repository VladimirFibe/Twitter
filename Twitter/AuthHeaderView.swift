import SwiftUI

struct AuthHeaderView: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(height: 260)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading)
            .background(Color(.systemBlue))
            .foregroundColor(.white)
            .clipShape(RoundedShape(corners: .bottomRight))
            .ignoresSafeArea()
    }
}
