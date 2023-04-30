//
//  SignInView.swift
//  Twitter
//
//  Created by Vladimir on 30.04.2023.
//

import SwiftUI

struct SignInView: View {
    @ObservedObject var viewModel = SingInViewModel()
    var body: some View {
        fields
    }
    var fields: some View {
        VStack(spacing: 40) {
            CustomInputField(image: "envelope", placeholder: "Email", text: $viewModel.email)
            CustomInputField(image: "lock", placeholder: "Password", text: $viewModel.password, isSecure: true)
        }
        .padding(.horizontal, 32)
        .padding(.top, 44)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
