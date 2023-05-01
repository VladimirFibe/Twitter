import SwiftUI

struct SignUpView: View {
    @ObservedObject var viewModel: SignUpViewModel
    var body: some View {
        VStack {
            AuthHeaderView(text: "Get started.\nCreate your account")
            fields
            signup
            Spacer()
            signin
        }
    }
    var fields: some View {
        VStack(spacing: 40) {
            CustomInputField(image: "envelope", placeholder: "Email", text: $viewModel.email)
            CustomInputField(image: "person", placeholder: "Username", text: $viewModel.username)
            CustomInputField(image: "person", placeholder: "Full name", text: $viewModel.fullname)
            CustomInputField(image: "lock", placeholder: "Password", text: $viewModel.password, isSecure: true)
        }
        .padding(.horizontal, 32)
    }
    var signup: some View {
        Button(action: viewModel.signUpHadler) {
            PrimaryButtonView(title: "Sign Up")
        }
    }
    
    var signin: some View {
        Button(action: viewModel.signin) {
            HStack {
                Text("Already have an account?")
                Text("Sign In")
                    .fontWeight(.semibold)
            }
            .font(.footnote)
        }
    }
}
