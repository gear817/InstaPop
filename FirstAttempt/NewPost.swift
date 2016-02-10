//
//  NewPost.swift
//  FirstAttempt
//
//  Created by Joseph Mouer on 2/10/16.
//  Copyright © 2016 Danny Vasquez. All rights reserved.
//

import Foundation

class NewPost{
    
    let photoString: String
    let aboutPhoto: String
    let photoPoster: String
    let photoPhoto: NSData
    
    
    init (photoDictionary: [String:AnyObject])
    {
        photoString = photoDictionary["photos"] as! String
        aboutPhoto = photoDictionary["about"] as! String
        photoPoster = photoDictionary["users"] as! String  //THIS NEEDS TO BE FIXED
        
        
        photoPhoto = NSData(base64EncodedString: photoString, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!
        
    }
    
    
    
    
}