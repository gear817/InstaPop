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

    
    @IBOutlet weak var collectionViewCell: UICollectionView!
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionViewCell.reloadData()
        
        if NSUserDefaults.standardUserDefaults().valueForKey("userID") != nil && DataService.dataService.CURRENT_USER_REF.authData != nil {
            //self.performSegueWithIdentifier("LoginSegue", sender: nil)
        }
        else
        {
            //    self.performSegueWithIdentifier("ToProfile", sender: nil)
        }
        
        let ref = Firebase(url: BASE_URL + "/photos")
        
        
        ref.observeEventType(.Value, withBlock: { snapshot in
            
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                
                self.photos = []
                
                for snap in snapshots {
                    let photoDictionary = snap.value as? Dictionary<String, AnyObject>
                    
                    let newPhoto = NewPost(photoDictionary: photoDictionary!)
                    
                    self.postPhotos.append(newPhoto)
                }
                self.collectionViewCell.reloadData()
                
            }
            }, withCancelBlock: { error in
                print(error.description)
        })
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: CCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCell", forIndexPath: indexPath) as! CCollectionViewCell
        print(photos.count)
        if photos.count > 0 {
            cell.imageView.image = photos [indexPath.row] as! UIImage
            
        }
        
        return cell
        
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    
    @IBAction func onTapTakePicture(sender: UIBarButtonItem) {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            //load the camera interface
            let picker : UIImagePickerController = UIImagePickerController()
            
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.delegate = self
            picker.allowsEditing = false
            self.presentViewController(picker, animated: true, completion: nil)
            
        }else{
            //no camera available
            let alert = UIAlertController(title: "Error", message: "There is no camera available", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: {(alertAction)in
                alert.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    @IBAction func picFromLib(sender: AnyObject) {
        let picker : UIImagePickerController = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(.PhotoLibrary)!
        
        picker.delegate = self
        picker.allowsEditing = false
        
        self.presentViewController(picker, animated: true, completion: nil)
        
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "NewPhotoSegue"
        {
            let dvc = segue.destinationViewController as! NewPhotoViewController
            
            let cell = sender as! UICollectionViewCell
            
            let indexPath = self.collectionViewCell!.indexPathForCell(cell)
            
            dvc.photo = photos [(indexPath?.row)!] as! NewPost
            
            
        }
        
    }

    
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        print (image)
        photos.addObject(image)
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let currentPhotosArray = userDefaults.objectForKey("userPhotos")
        
        currentUserPhotosMutableArray.addObject(image)
        userDefaults.setObject(currentUserPhotosArray, forKey: "userPhotos")
        self.collectionViewCell.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}



