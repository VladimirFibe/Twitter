import SwiftUI

struct ProfilePhotoSelectorView: View {
    @ObservedObject var viewModel: ProfilePhotoSelectorViewModel
    var body: some View {
        VStack {
            AuthHeaderView(text: "Create your account\nSelect a profile photo")
            Button(action: viewModel.presentPicker) {
                if let profileImage = viewModel.profileImage {
                    profileImage
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                } else {
                    Image("plus_photo")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color(.systemBlue))
                        .scaledToFill()
                }
            }
            .frame(width: 180, height: 180)
            
            if viewModel.selectedImage != nil {
                Button(action: viewModel.saveImage) {
                    PrimaryButtonView(title: "Continue")
                }
            }
            Spacer()

        }
    }
}

private struct ProfileImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
    }
}
