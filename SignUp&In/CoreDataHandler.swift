//  CoreDataHandler.swift
//  SignUp&In
//  Created by Ranjeet Raushan on 10/06/18.
//  Copyright © 2018 Vaayoo. All rights reserved.

import UIKit
import CoreData
class CoreDataHandler: NSObject {
    private class func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    class func saveObject(fname:String,lname:String,email:String,password:String,confirmPassword:String,gender:String,maritalStatus:String ,puc:String , btech:String,masters:String,phd:String,phoneType:String,dob:String) -> Bool{
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        manageObject.setValue(fname, forKey: "fname")
        manageObject.setValue(lname, forKey: "lname")
        manageObject.setValue(email, forKey: "email")
        manageObject.setValue(password, forKey: "password")
        manageObject.setValue(confirmPassword, forKey: "confirmPassword")
        manageObject.setValue(gender, forKey: "gender")
        manageObject.setValue(maritalStatus, forKey: "maritalStatus")
        manageObject.setValue(phoneType, forKey: "phoneType")
        manageObject.setValue(puc, forKey: "puc")
        manageObject.setValue(btech, forKey: "btech")
        manageObject.setValue(masters, forKey: "masters")
        manageObject.setValue(phd, forKey: "phd")
        manageObject.setValue(dob, forKey: "dob")
        
        do {
            try context.save()
            return true
        }catch{
            return false
        }
    }
    class func fetchObject() -> [User]?{
        let context =  getContext()
        var user:[User]? = nil
        do{
            user = try context.fetch(User.fetchRequest())
            return user
        }catch{
            return user
        }
    }
}
