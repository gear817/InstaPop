//
//  ResetViewController.swift
//  FirstAttempt
//
//  Created by Danny Vasquez on 2/10/16.
//  Copyright © 2016 Danny Vasquez. All rights reserved.
//

import UIKit
import Firebase
class ResetViewController: UIViewController {

    @IBOutlet weak var emaiTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "rain")!)
//        let alert = UIAlertController(title: "Hello!", message: "You are expected to enter an email in order for us to process your request!", preferredStyle: UIAlertControllerStyle.Alert)
//        let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil)
//        alert.addAction(ok)
        self.displayAlert()
    }
    
    
    func displayAlert() -> Void {
        let alert = UIAlertController(title: "Hello!", message: "You are expected to enter an email in order for us to process your request!", preferredStyle: UIAlertControllerStyle.Alert)
        let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(ok)
        self.presentViewController(alert, animated: true, completion: nil)

    }
    
    
    
    

    @IBAction func onResetTapped(sender: AnyObject) {
        let email = emaiTextField.text
        
        let ref = Firebase(url: "instapop.firebaseIO.com")
        
        ref.resetPasswordForUser(email) { (error) -> Void in
            if error != nil {
                //there was a problem processing the request
                print(error?.localizedDescription)
                let alert = UIAlertController(title: "Error", message: "There was an error processing the request. Please try again", preferredStyle: UIAlertControllerStyle.Alert)
                
                let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil)
                
                alert.addAction(ok)
                self.presentViewController(alert, animated: true, completion: nil)
                
            }else {
                // password reset sent successfully
                let alert = UIAlertController(title: "Your temporary password", message: "Has been sent to your email please login with the provided password", preferredStyle: UIAlertControllerStyle.Alert)
                
                //if user presses okay call the dismiss VC
                
                let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
//                    self.dismissViewControllerAnimated(true, completion: nil)
                })
                alert.addAction(ok)
                self.presentViewController(alert, animated: true, completion: nil)
//                self.dismissViewControllerAnimated(true, completion: nil)


            }
        }
        
    }
    
}
