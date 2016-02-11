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



class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var postPhotos = [NewPost]()
    var photos: NSMutableArray = []
    var currentUserPhotosMutableArray: NSMutableArray = []

class CollectionViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Properties
    
    override func viewDidAppear(animated: Bool) {
        
    }
    var postPhotos = [Post]()
    var photos: NSMutableArray = []
    var currentUserPhotosMutableArray: NSMutableArray = []
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.reloadData()
        
        if NSUserDefaults.standardUserDefaults().valueForKey("userID") != nil && DataService.dataService.CURRENT_USER_REF.authData != nil {
            //self.performSegueWithIdentifier("LoginSegue", sender: nil)
        } else {
            //    self.performSegueWithIdentifier("ToProfile", sender: nil)
        }
        
        let ref = Firebase(url: BASE_URL + "/photos")
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                self.photos = []
                
                for snap in snapshots {
                    
                    let photoDictionary = snap.value as? Dictionary<String, AnyObject>
                    let newPost = Post()
                    
                    newPost.setupWithDictionary(photoDictionary: photoDictionary!)
                    
                    self.postPhotos.append(newPost)
                }
                
                self.collectionView.reloadData()
            }
            }, withCancelBlock: { error in
                print(error.description)
        })
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
    
    @IBAction func onCommentTapped(sender: AnyObject) {
        
    }
    @IBOutlet weak var onLikeTapped: UIButton!

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "NewPhotoSegue"
        {
            let dvc = segue.destinationViewController as! NewPhotoViewController
            
            let cell = sender as! UICollectionViewCell
            
            let indexPath = self.collectionViewCell!.indexPathForCell(cell)
            
            dvc.photo = photos [(indexPath?.row)!] as! NewPost
            
            
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
        
        //        let currentPhotosArray = userDefaults.objectForKey("userPhotos")
        
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
            cell.imageView.image = photos [indexPath.row] as! UIImage
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
}
}
