//
//  CollectionViewController.swift
//  FirstAttempt
//
//  Created by Danny Vasquez and Joseph Mouer on 2/4/16.
//  Copyright © 2016 Danny Vasquez and Joseph Mouer. All rights reserved.
//

import UIKit
import MapKit
import Photos
import CoreLocation
import Firebase


class CollectionViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    // MARK: Properties
    
    var postPhotos = [Post]()
    var photos: NSMutableArray = []
    var currentUserPhotosMutableArray: NSMutableArray = []
    var ref = Firebase(url: BASE_URL + "/photos")
    var commentTextField = UITextField()
    var commentsArray: NSMutableArray = []

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.reloadData()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    // MARK: - Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "NewPhotoSegue" {
            let dvc = segue.destinationViewController as! NewPhotoViewController
            let cell = sender as! PostCollectionViewCell
            let post = Post()
            
            post.image = cell.imageView.image
            dvc.post = post
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func picFromLib(sender: AnyObject) {
        
        let picker : UIImagePickerController = UIImagePickerController()
        
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(.PhotoLibrary)!
        picker.delegate = self
        picker.allowsEditing = false
        
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    
    
    @IBAction func onCommentTapped(sender: AnyObject) {
        let alertController = UIAlertController(title: "Add Comment", message: nil, preferredStyle: .Alert)
        let ok = UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            print("Ok Button Pressed")
            self.commentsArray.addObject(self.commentTextField)
            print(self.commentsArray)

        })
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) -> Void in
            print("Cancel Button Pressed")
        }
        alertController.addAction(ok)
        alertController.addAction(cancel)
    
        alertController.addTextFieldWithConfigurationHandler { (textField) -> Void in
            self.commentTextField = textField
            self.commentTextField.placeholder = "Enter comment"
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    // MARK: - Helpers
    
    @IBAction func onTapTakePicture(sender: UIBarButtonItem) {
        
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            
            // Load the camera interface.
            let picker : UIImagePickerController = UIImagePickerController()
            
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.delegate = self
            picker.allowsEditing = false
            self.presentViewController(picker, animated: true, completion: nil)
            
        } else {
            
            // No camera available.
            let alert = UIAlertController(title: "Error", message: "There is no camera available", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: {(alertAction)in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - UIImagePickeControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        self.photos.addObject(image)
        
        self.currentUserPhotosMutableArray.addObject(image)
        userDefaults.setObject(currentUserPhotosArray, forKey: "userPhotos")
        self.collectionView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
}


// MARK: - UINavigationControllerDelegate, UIImagePickerControllerDelegate

extension CollectionViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
}

// MARK: - UICollectionViewDataSource

extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: PostCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCell", forIndexPath: indexPath) as! PostCollectionViewCell
        
        
        if photos.count > 0 {
            cell.imageView.image = (photos [indexPath.row] as! UIImage)
        }
        
        if commentsArray.count > 0 {
        cell.commentTextView.text = (commentsArray [indexPath.row] as! String)
        
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
}
