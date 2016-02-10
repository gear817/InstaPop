//
//  NewPhotoViewController.swift
//  FirstAttempt
//
//  Created by Danny Vasquez on 2/4/16.
//  Copyright © 2016 Danny Vasquez. All rights reserved.
//

import UIKit

class NewPhotoViewController: UIViewController {

    @IBOutlet weak var commentTextView: UITextView!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var usernameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    

    @IBAction func usernameButton(sender: AnyObject) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
