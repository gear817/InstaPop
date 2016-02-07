//
//  CollectionViewController.swift
//  FirstAttempt
//
//  Created by Danny Vasquez on 2/4/16.
//  Copyright © 2016 Danny Vasquez. All rights reserved.
//

import UIKit
import MapKit


class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var collectionViewCell: UICollectionView!
    
    @IBOutlet weak var imageView: UIImageView!
    
 
    
    let imageArray = [UIImage(named: "uni1"), UIImage(named: "uni2"), UIImage(named: "uni3"), UIImage(named: "uni4"), UIImage(named: "uni5")]

    
    
    
    
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
    
    
    @IBAction func onTapTakePicture(sender: UIBarButtonItem) {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .Camera
        self.imageView(picker, animated: true, completion: { _ in })
    }
    
    
    @IBAction func picFromLib(sender: AnyObject) {
       let picker: UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .PhotoLibrary
        self.presentViewController(picker, animated: true, completion: { _ in })
    }
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let dvc = segue.destinationViewController as! CollectionViewController
//        dvc.title = 
//    }

}
