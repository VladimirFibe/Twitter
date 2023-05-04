//
//  MLoginStore.swift
//  Twitter
//
//  Created by Vladimir on 03.05.2023.
//

import Foundation
import Foundation
import FirebaseAuth
import FirebaseFirestore

enum MLoginEvent {
    case notVerifiedEmail
    case linkForVerifySended
    case linkForResetPasswordSended
    case login
}

enum MLoginAction {
    case signInWith(String, String)
    case signUpWith(String, String)
    case sendEmailVerification
    case sendPasswordReset(String)
}

final class MLoginStore: Store<MLoginEvent, MLoginAction> {
    override func handleActions(action: MLoginAction) {
        switch action {
        case .signUpWith(let email, let password):
            statefulCall {
                try await self.signUpWith(email: email, password: password)
            }
        case .signInWith(let email, let password):
            statefulCall {
                try await self.signIn(withEmail: email, password: password)
            }
        case .sendEmailVerification:
            statefulCall(sendEmailVerification)
        case .sendPasswordReset(let email):
            statefulCall {
                try await self.sendPasswordReset(withEmail: email)
            }
        }
    }
    
    private func sendPasswordReset(withEmail email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
        sendEvent(.linkForResetPasswordSended)
    }
    
    private func sendEmailVerification() async throws {
        try await Auth.auth().currentUser?.sendEmailVerification()
        sendEvent(.linkForVerifySended)
    }
    
    private func signIn(withEmail email: String, password: String) async throws {
        let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
        if authResult.user.isEmailVerified {
            try await fetchPerson()
            sendEvent(.login)
        } else {
            sendEvent(.notVerifiedEmail)
        }
    }

    private func signUpWith(email: String, password: String) async throws {
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let uid = authResult.user.uid
        let person = Person(fullname: "", username: email, email: email, profileImageUrl: "")
        try Firestore.firestore().collection("persons").document(uid).setData(from: person)
        Person.currentPerson = person
        try await sendEmailVerification()
    }
    
    private func fetchPerson() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await Firestore.firestore().collection("persons")
            .document(uid)
            .getDocument()
        guard let person = try? snapshot.data(as: Person.self) else { return}
        Person.currentPerson = person
    }
}
