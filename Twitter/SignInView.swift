import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel: SingInViewModel
    var body: some View {
        VStack {
            AuthHeaderView(text: "Hello\nWelcome Back")
            fields
            forgotPassword
            signin
            Spacer()
            signup
        }
    }
    var fields: some View {
        VStack(spacing: 40) {
            CustomInputField(image: "envelope",
                             placeholder: "Email",
                             text: $viewModel.email)
                .autocapitalization(.none)
            CustomInputField(image: "lock",
                             placeholder: "Password",
                             text: $viewModel.password,
                             isSecure: true)
        }
        .padding(.horizontal, 32)
        .padding(.top, 44)
    }
    
    var forgotPassword: some View {
    
        Button(action: viewModel.signInHandler) {
            Text("Forgot Password?")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(Color(.systemBlue))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top)
                .padding(.trailing, 24)
        }
    }
    
    var signin: some View {
        Button(action: viewModel.signInHandler) {
            PrimaryButtonView(title: "Sign In")
        }
    }
    
    var signup: some View {
        Button(action: viewModel.signup) {
            HStack {
                Text("Don't have an account?")
                
                Text("Sign Up")
                    .fontWeight(.semibold)
            }
            .font(.footnote)
        }
    }
}
