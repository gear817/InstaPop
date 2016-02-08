//
//  CollectionViewController.swift
//  FirstAttempt
//
//  Created by Danny Vasquez on 2/4/16.
//  Copyright © 2016 Danny Vasquez. All rights reserved.
//

import UIKit
import MapKit
import Photos
import CoreLocation


let reuseIdentifier = "PhotoCell"
let albulmName = "App Folder1"
var location = CLLocation()
var picLocation: PHAsset = PHAsset()




class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    
    @IBOutlet weak var collectionViewCell: UICollectionView!
    

//    let imageArray = [UIImage(named: "uni1"), UIImage(named: "uni2"), UIImage(named: "uni3"), UIImage(named: "uni4"), UIImage(named: "uni5")]

    
    override func viewDidAppear(animated: Bool) {
//        // 1
//        let nav = self.navigationController?.navigationBar
//        // 2
//        nav?.barStyle = UIBarStyle.Black
//        nav?.tintColor = UIColor.yellowColor()
//        // 3
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        imageView.contentMode = .ScaleAspectFit
//        // 4
//        let image = UIImage(named: "home")
//        imageView.image = image
//        // 5
//        navigationItem.titleView = imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCell", forIndexPath: indexPath)
        
        return cell
    }

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
//        var metadata: [NSObject : AnyObject] = info[UIImagePickerControllerMediaMetadata]
//    }
    
    
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
    


    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let dvc = segue.destinationViewController as! CollectionViewController
//        dvc.title = 
//    }

}
