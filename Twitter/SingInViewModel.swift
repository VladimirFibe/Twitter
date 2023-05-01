import Foundation

final class SingInViewModel: ObservableObject {
    @Published var email = "vladimir@fibeapp.ru"
    @Published var password = "123456"
    
    var signup: Callback
    let signin: (String, String) -> ()
    
    init(signup: @escaping Callback,
         signin: @escaping (String, String) -> ()) {
        self.signup = signup
        self.signin = signin
    }
    
    func signInHandler() {
        signin(email, password)
    }
}
