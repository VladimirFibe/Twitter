//
//  AuthService.swift
//  Twitter
//
//  Created by Vladimir Fibe on 21.02.2022.
//

import UIKit
import Firebase
import FirebaseDatabase

struct AuthCredentials {
  let email: String
  let password: String
  let fullname: String
  let username: String
  let imageData: Data
}

struct AuthService {
  static let shared = AuthService()
  
  func login(withEmail email: String, password: String, competion: @escaping (AuthDataResult?, Error?) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password, completion: competion)
  }
  
  func registerUser(credentials: AuthCredentials, completion: @escaping (Error?, DatabaseReference) -> Void) {
    
    
    Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
      if let error = error {
        print("DEBUG: \(error.localizedDescription)")
        return
      }
      guard let uid = result?.user.uid else { return }
      let storageRef = STORAGE_PROFILE.child(uid)
      storageRef.putData(credentials.imageData, metadata: nil) { meta, error in
        storageRef.downloadURL { url, error in
          guard let profileImageUrl = url?.absoluteString else { return }
          let values = [
            "email": credentials.email,
            "username": credentials.username,
            "fullname": credentials.fullname,
            "profile": profileImageUrl
          ]
          REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
        }
      }
    }
  }
}
