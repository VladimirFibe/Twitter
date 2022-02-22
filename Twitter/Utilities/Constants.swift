//
//  Constants.swift
//  Twitter
//
//  Created by Vladimir Fibe on 21.02.2022.
//

import Firebase
import FirebaseDatabase
import FirebaseStorage
let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE = STORAGE_REF.child("profile")
