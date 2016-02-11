
//
//  DataService.swift
//  FirstAttempt
//
//  Created by Danny Vasquez on 2/8/16.
//  Copyright © 2016 Danny Vasquez. All rights reserved.
//

import Foundation
import Firebase
class DataService {
    static let dataService = DataService()
    
    private var _BASE_REF = Firebase(url: "\(BASE_URL)")
    private var _USER_REF = Firebase(url: "\(BASE_URL)/users")
    private var _PHOTO_REF = Firebase(url: "\(BASE_URL)/photos")
    
    var BASE_REF: Firebase {
        return _BASE_REF
    }
    
    var USER_REF: Firebase {
        return _USER_REF
    }
    
    var CURRENT_USER_REF: Firebase {

        let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String
        let currentUser = Firebase(url: "\(BASE_REF)").childByAppendingPath("users").childByAppendingPath(userID)
//        let currentUser = Firebase()
        
        return currentUser
    }
    
    var PHOTO_REF: Firebase {
        return self.PHOTO_REF
    }
    
    
    func createNewAccount(uid: String, user: Dictionary<String, AnyObject>) {
        USER_REF.childByAppendingPath(uid).setValue(user)
    }
}
