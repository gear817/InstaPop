//
//  CollectionViewController.swift
//  FirstAttempt
//
//  Created by Danny Vasquez on 2/4/16.
//  Copyright © 2016 Danny Vasquez. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionViewCell: UICollectionView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imageArray = [UIImage(named: "uni1"), UIImage(named: "uni2"), UIImage(named: "uni3"), UIImage(named: "uni4"), UIImage(named: "uni5")]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellID", forIndexPath: indexPath)
        
        return cell
    }

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let dvc = segue.destinationViewController as! CollectionViewController
//        dvc.title = 
//    }

}
