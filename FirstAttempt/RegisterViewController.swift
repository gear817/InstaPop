//
//  RegisterViewController.swift
//  FirstAttempt
//
//  Created by Danny Vasquez on 2/8/16.
//  Copyright © 2016 Danny Vasquez. All rights reserved.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController {
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    var myRootRef = Firebase(url:"https://instapop.firebaseio.com/")

    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func onRegisterButtonTapped(sender: AnyObject) {
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        let userRepeatPassword = repeatPasswordTextField.text
        
        // check for empty fields
        if (userEmail!.isEmpty || userPassword!.isEmpty || userRepeatPassword!.isEmpty) {
            //display alert message
            displayMyAlertMessage("All fields are required")
            return;
        }
        
        //check if passwords match
        if (userPassword != userRepeatPassword) {
            //display an alert message
            displayMyAlertMessage("Passwords do not match")
            return;
        }
        
        //store data
        
        myRootRef.setValue(userEmail)
        
        
        
        
        
        // display alert message with confirmation
        var myAlert = UIAlertController(title: "Alert", message: "Registration is successful, thank you!", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default){ action in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func displayMyAlertMessage(userMessage: String) {
        var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated:true, completion: nil)
        
    }

    

}
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


