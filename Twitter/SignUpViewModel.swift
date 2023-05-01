import Foundation

final class SignUpViewModel: ObservableObject {
    @Published var email = "vladimir@fibeapp.ru"
    @Published var password = "123456"
    @Published var username = "macuser"
    @Published var fullname = "Vladimir Fibe"
    
    let signup: (String, String, String, String) -> ()
    let signin: Callback
    
    init(signup: @escaping (String, String, String, String) -> Void,
         signin: @escaping Callback) {
        self.signup = signup
        self.signin = signin
    }
    
    func signUpHadler() {
        signup(email, password, fullname, username)
    }
}


