import SwiftUI

struct CustomInputField: View {
    var image: String
    var placeholder: String
    @Binding var text: String
    var isSecure = false
    var body: some View {
        VStack {
            HStack {
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))
                if isSecure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            Divider().background(Color(.darkGray))
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(image: "envelope", placeholder: "Email", text: .constant(""))
    }
}
