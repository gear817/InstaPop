//
//  NewPost.swift
//  FirstAttempt
//
//  Created by Joseph Mouer on 2/10/16.
//  Copyright © 2016 Danny Vasquez. All rights reserved.
//

import Foundation
import UIKit

class Post {
    
    var photoString: String?
    var aboutPhoto: String?
    var photoPoster: String?
    var photoPhoto: NSData?
    
    var image: UIImage?
    
    func setupWithDictionary(photoDictionary photoDictionary: NSDictionary) {
        self.photoString = photoDictionary["photos"] as? String
        self.aboutPhoto = photoDictionary["about"] as? String
        self.photoPoster = photoDictionary["users"] as? String  //THIS NEEDS TO BE FIXED
        
        self.photoPhoto = NSData(base64EncodedString: photoString!, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)!
    }
}