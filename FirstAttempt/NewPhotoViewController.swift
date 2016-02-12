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

     // MARK: IBOutlets
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var usernameButton: UIButton!
    
    var ref = Firebase (url: BASE_URL + "/photos")
    
    var post: Post!
    
    
    // MARK: Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton.enabled = true
        self.photoImageView.image = self.post.image
    }

    
    // MARK: IBActions
    
    @IBAction func onTapShare(sender: AnyObject) {
        uploadPhoto()
        self.photoImageView.image = self.post.image
        commentTextView.text = ""
        shareButton.enabled = true
    }

    
    // MARK: Helperfunctions
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage
        photoImageView.image = chosenImage
        picker.dismissViewControllerAnimated(true, completion: nil)
        shareButton.enabled = true
    
    }
    
    func uploadPhoto()
    {
        //let postRef = ref.childByAppendingPath("posts")
        var aboutPhoto = ""
        
        if commentTextView.text != "Tap to add description" && commentTextView.text.isEmpty == false
        {
            aboutPhoto = commentTextView.text
        }
        
        let smallerPhoto = (UIImageJPEGRepresentation(photoImageView.image!, 0.6))!
        
        let photoUpload = smallerPhoto.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        
        let post1 = ["uid": NSUserDefaults.standardUserDefaults().valueForKey("uid")!, "photo": photoUpload, "about": aboutPhoto]
        let post1Ref = ref.childByAutoId()
        post1Ref.setValue(post1)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"
        {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }


}
