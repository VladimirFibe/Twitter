import SwiftUI

struct PrimaryButtonView: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.white)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color(.systemBlue))
            .clipShape(Capsule())
            .padding(.top)
            .padding(.horizontal, 24)
            .shadow(color: .gray.opacity(0.5), radius: 10)
    }
}
