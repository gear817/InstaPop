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
    @IBOutlet weak var userNameTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func onRegisterButtonTapped(sender: AnyObject) {
        let userName = userNameTextfield.text
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
//        let userRepeatPassword = repeatPasswordTextField.text
        
        // check for empty fields
        if (userEmail != "" && userPassword != "" && userName != "") {
            
            DataService.dataService.BASE_REF.createUser(userEmail, password: userPassword, withValueCompletionBlock: { (error, result) -> Void in
                if error != nil {
                    self.signupErrorAlert("Oops!", message: "Having trouble creating your account. Try again")
                }else {
                    DataService.dataService.BASE_REF.authUser(userEmail, password: userPassword, withCompletionBlock: { (error, authData) -> Void in
                        let user = ["password": authData.provider!, "email": userEmail!, "userName": userName!]
                        DataService.dataService.createNewAccount(authData.uid, user: user)
                    })
                    
                    NSUserDefaults.standardUserDefaults().setValue(result["uid"], forKey: "uid")
                    
                    self.performSegueWithIdentifier("BackToLogin", sender: nil)
                }
            })
        }else {
            signupErrorAlert("Oops!", message: "Don't forget to enter your email, password, and username.")
            
        }
    }
    
    func signupErrorAlert(title: String, message: String) {
        
        // Called upon signup error to let the user know signup didn't work.
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func cancelCreateAccount(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
//    func displayMyAlertMessage(userMessage: String) {
//        var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
//        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil)
//        
//        myAlert.addAction(okAction)
//        
//        self.presentViewController(myAlert, animated:true, completion: nil)
//        
//    }

    

}
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


