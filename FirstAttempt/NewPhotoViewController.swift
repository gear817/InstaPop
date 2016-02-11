//
//  NewPhotoViewController.swift
//  FirstAttempt
//
//  Created by Danny Vasquez on 2/4/16.
//  Copyright © 2016 Danny Vasquez. All rights reserved.
//

import UIKit
import Firebase

class NewPhotoViewController: UIViewController {

    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var usernameButton: UIButton!
    
    var post: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.photoImageView.image = self.post.image
    }

    @IBAction func onTapShare(sender: AnyObject) {
    
    
    
    }
    @IBAction func usernameButton(sender: AnyObject) {
        
    }



}
