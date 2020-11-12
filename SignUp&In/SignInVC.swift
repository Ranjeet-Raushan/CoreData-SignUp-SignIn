//  SignInVC.swift
//  SignUp&In
//  Created by Ranjeet Raushan on 10/06/18.
//  Copyright © 2018 Vaayoo. All rights reserved.

import UIKit
import CoreData
class SignInVC: UIViewController {
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var user:[User]? = nil
    @IBAction func logine(_ sender: Any) {
        let Email = txtEmail.text
        let Password =  txtPassword.text
        
        // from userdefault
        var  EmailStored = UserDefaults.standard.string(forKey: "Email");
        var  PasswordStored = UserDefaults.standard.string(forKey: "Password");
        // from coredata
        
        user = CoreDataHandler.fetchObject()
        for i in user! {
            /* Don't deleted commented code , cause it's a efficient way - starts here */
            //  print("\(i.fname!),\(i.lname!),\(i.email!), \(i.password!),\(i.confirmPassword!),\(i.gender!),\(i.phoneType!),\(i.dob!)")
            /* Don't deleted commented code , cause it's a efficient way - ends here */
            print("\(i.fname!)")
            print("\(i.lname!)")
            print("\(i.email!)")
            print("\(i.password!)")
            print("\(i.confirmPassword!)")
            print("\(i.gender!)")
            print("\(i.maritalStatus!)")
            print("\(i.phoneType!)")
            print("\(i.puc!)")
            print("\(i.btech!)")
            print("\(i.masters!)")
            print("\(i.phd!)")
            print("\(i.dob!)")
            
            EmailStored = i.email
            PasswordStored = i.password
        }
        if EmailStored == Email && PasswordStored == Password
        {
                // Login is Successful & Error
UserDefaults.standard.set(true,forKey:"isUserLoggedIn")
                UserDefaults.standard.synchronize()
                displayMyAlertMessage(userMessage: "Login successful")
            print("Login successful")
            
         }else {
            displayMyAlertMessage(userMessage: "Login failed")
            print("Login failed")

        }
}
    func displayMyAlertMessage(userMessage:String){
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
        self.dismiss(animated: true, completion: nil)
        })
        myAlert.addAction(okAction)
        self.present(myAlert,animated: true,completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

