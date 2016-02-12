//
//  UserTableViewController.swift
//  FirstAttempt
//
//  Created by Joseph Mouer on 2/11/16.
//  Copyright © 2016 Danny Vasquez. All rights reserved.
//

import UIKit
import Firebase


class UserTableViewController: UITableViewController {
    
    // MARK: Constants
    
    
    let usersRef = Firebase(url: "https://instapop.firebaseIO.com/users")
    
    // MARK: Properties
    
    var currentUsers: [String] = [String]()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersRef.observeEventType(.ChildAdded, withBlock: { (snap: FDataSnapshot!) in
            
            print(snap.value)
    
            self.currentUsers.append(snap.value as! String)
            
            let row = self.currentUsers.count - 1
            
            let indexPath = NSIndexPath(forRow: row, inSection: 0)
            
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Top)
            
        })
        
        usersRef.observeEventType(.ChildRemoved, withBlock: { (snap: FDataSnapshot!) -> Void in
            
            // Get the username to find
            let userToFind: String! = snap.value as! String
            
            // Loop to find the email in the array
            for(index, username) in self.currentUsers.enumerate() {
                
                // If the email is found, delete it from the table with an animation
                if username == userToFind {
                    let indexPath = NSIndexPath(forRow: index, inSection: 0)
                    self.currentUsers.removeAtIndex(index)
                    self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                }
                
            }
            
        })
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentUsers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell")! as UITableViewCell
        let userName = currentUsers[indexPath.row]
        cell.textLabel?.text = userName
        return cell
    }
    
}
