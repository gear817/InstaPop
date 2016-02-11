//
//  Users.swift
//  FirstAttempt
//
//  Created by Joseph Mouer on 2/11/16.
//  Copyright © 2016 Danny Vasquez. All rights reserved.
//

import Foundation
import Firebase

struct User {
    let uid: String
    let email: String
    let username: String
    
    // Initialize from Firebase
    init(authData: FAuthData) {
        uid = authData.uid
        email = authData.providerData["email"] as! String
        username = authData.providerData["username"] as! String
    
    }
    
    // Initialize from arbitrary data
    init(uid: String, email: String, username: String) {
        self.uid = uid
        self.email = email
        self.username = username
    }
}