//  ViewController.swift
//  SignUp&In
//  Created by Ranjeet Raushan on 10/06/18.
//  Copyright © 2018 Vaayoo. All rights reserved.

import UIKit
class ViewController: UIViewController , UIPickerViewDataSource , UIPickerViewDelegate {
    @IBOutlet weak var genderr: UILabel!
    @IBAction func `switch`(_ sender: UISwitch) {
      if(sender.isOn == true)
      {
        genderr.text = "Male"
      }
      else {
        genderr.text = "Female"
        }
    }
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var phonetypetxtfld: UITextField!
    @IBOutlet weak var dateField: UITextField!
    
    // Married   UnMarried
    @IBOutlet weak var marrieed: UIButton!
    @IBOutlet weak var unmarrieed: UIButton!
    @IBAction func onRadioButtonSelection(_ sender: UIButton) {
        if let buttonTitle = sender.title(for: .normal) {
            //butt
            if buttonTitle == "Married"{
               marrieed.setImage(#imageLiteral(resourceName: "radio_checked"), for: .normal)
                unmarrieed.setImage(#imageLiteral(resourceName: "radio_unchecked"), for: .normal)
            }else{
        unmarrieed.setImage(#imageLiteral(resourceName: "radio_checked"), for: .normal)
                marrieed.setImage(#imageLiteral(resourceName: "radio_unchecked"), for: .normal)
            }
        }
    }
    // PUC  B.Tech   Masters   PHD
    @IBOutlet weak var pucc: UIButton!
    @IBOutlet weak var btechh: UIButton!
    @IBOutlet weak var masterss: UIButton!
    @IBOutlet weak var phdd: UIButton!
    @IBAction func onCheckBoxChecked(_ sender: UIButton) {
            if   let img  = sender.image(for: .normal){
                if img == #imageLiteral(resourceName: "checkbox_checked") {
                    sender.setImage(#imageLiteral(resourceName: "checkbox_unchecked"), for: .normal)
                }else {
                    sender.setImage(#imageLiteral(resourceName: "checkbox_checked"), for: .normal)
                }
            }
    }
    let phoneTypes = ["Mobile","Home","LandLine","Office","Business","Personal"]
     let picker = UIDatePicker()
    override func viewDidLoad() {
        pickerView.delegate = self
        pickerView.dataSource = self
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createDatePicker()
       

    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
    return phoneTypes.count
}
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return phoneTypes[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        phonetypetxtfld.text = phoneTypes[row]
    }
   
    func createDatePicker(){
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done],animated: false)
        dateField.inputAccessoryView = toolbar
        dateField.inputView = picker
        
       //format picker for date
        picker.datePickerMode = .date
        
    }
    @objc func donePressed(){
        //  format date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: picker.date)
        dateField.text = "\(dateString)"
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //SignUp Form
    
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var txtLName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    @IBAction func regstratiion(_ sender: Any) {
        let FName = txtFName.text
        let LName = txtLName.text
        let Email = txtEmail.text
        let Password =  txtPassword.text
        let ConfirmPassword = txtConfirmPassword.text
        let Gender = genderr.text
        let PhoneType = phonetypetxtfld.text
        let DOB = dateField.text
        var maritalStatus = ""
        if let img  = marrieed.image(for: .normal){
            if img == #imageLiteral(resourceName: "radio_checked") {
              maritalStatus = "married"
            }else {
              maritalStatus = "unmarried"
            }
        }
        var puc = ""
        if let img  = pucc.image(for: .normal){
            if img == #imageLiteral(resourceName: "checkbox_checked") {
                puc = "puc"
            }else {
                   puc = ""
            }
         }
        var btech = ""
            if let img  = btechh.image(for: .normal){
                if img == #imageLiteral(resourceName: "checkbox_checked") {
                    btech = "btech"
                }else {
                    btech = ""
                }
        }
        var masters = ""
                if let img  = masterss.image(for: .normal){
                    if img == #imageLiteral(resourceName: "checkbox_checked") {
                        masters = "masters"
                    }else {
                        masters = ""
                    }
        }
        var phd = ""
                    if let img  = phdd.image(for: .normal){
                        if img == #imageLiteral(resourceName: "checkbox_checked") {
                            phd = "phd"
                        }else {
                            phd = ""
                        }
        }
        let EducationalDetails = [puc, btech, masters, phd]
        print(EducationalDetails)

        //Check for empty fields
        if((FName?.isEmpty)! || (LName?.isEmpty)! || (Email?.isEmpty)! || (Password?.isEmpty)! || (ConfirmPassword?.isEmpty)! || (Gender?.isEmpty)! || (maritalStatus.isEmpty) || (puc.isEmpty && btech.isEmpty && masters.isEmpty && phd.isEmpty) || (PhoneType?.isEmpty)! || (DOB?.isEmpty)! )
            
        {
            //Display alert message
            displayMyAlertMessage(userMessage: "All fields are required")
            return
        }
        
        //Check if passwords match
        if(Password != ConfirmPassword)
        {
            displayMyAlertMessage(userMessage: "Passwords do not match")
            return
        }
        

              let success: Bool = CoreDataHandler.saveObject(fname: FName!, lname: LName!, email: Email!, password: Password!, confirmPassword: ConfirmPassword!, gender: Gender!, maritalStatus: maritalStatus, puc: puc, btech: btech, masters: masters, phd: phd, phoneType: PhoneType!, dob: DOB!)
        

        if success {
            // success message
           displayMyAlertMessage(userMessage:"Registerd successfully")
            print("Inserted successfully")
           
        }else{
            // error msg
            displayMyAlertMessage(userMessage:"Registration failed")
            print("Insertion failed")
        }
        
    }
    func displayMyAlertMessage(userMessage:String){
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            let signinvc = self.storyboard?.instantiateViewController(withIdentifier: "signInvc") as? SignInVC
            self.present(signinvc!, animated: true, completion: nil)
            
        })
        
        myAlert.addAction(okAction)
        self.present(myAlert,animated: true,completion: nil)
    }
}

