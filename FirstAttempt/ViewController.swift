//
//  ViewController.swift
//  FirstAttempt
//
//  Created by Danny Vasquez on 2/4/16.
//  Copyright © 2016 Danny Vasquez. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    
    var myRootRef = Firebase(url:"https://instapop.firebaseio.com/")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        var ref = new Firebase(url: "instapop.firebaseIO.com")
    }

    override func viewDidAppear(animated: Bool) {
        self.performSegueWithIdentifier("ToLogin", sender: self)
    }

//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let dvc = segue.destinationViewController as! CollectionViewController
//    }
    
    
    
    
    
    
}

