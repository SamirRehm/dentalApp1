//
//  SignUpViewController.swift
//  dentalApp
//
//  Created by Sean Choi on 2017-12-09.
//  Copyright © 2017 Sean Choi. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var birthday: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var sex: UISegmentedControl!
    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 150, height: 150)) as UIActivityIndicatorView
    let datePicker = UIDatePicker()
    var firstName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpButtons()
        setUpNotification()
        createToolBar()
    }
    func setUpButtons() {
        register.layer.cornerRadius = 10
        backButton.layer.cornerRadius = 6
        sex.layer.cornerRadius = 10
        passwordField.isSecureTextEntry = true
        repeatPassword.isSecureTextEntry = true
    }
    
    func setUpNotification() {
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(self.actInd)
    }
    
    func createToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        datePicker.datePickerMode = .date
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolBar.setItems([flexibleSpace, doneButton], animated: false)

        birthday.inputAccessoryView = toolBar
        birthday.inputView = datePicker
        
        phoneField.inputAccessoryView = toolBar
        passwordField.inputAccessoryView = toolBar
        passwordField.textContentType = UITextContentType("")
        repeatPassword.inputAccessoryView = toolBar
        repeatPassword.textContentType = UITextContentType("")
        
        firstNameField.inputAccessoryView = toolBar
        lastNameField.inputAccessoryView = toolBar
        firstNameField.textContentType = UITextContentType("")
        lastNameField.textContentType = UITextContentType("")
    }
    
    @objc func doneClicked() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        birthday.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    
    
    @IBAction func registerButton(_ sender: Any) {
        checkForCompletion()
    }
    
    func checkForCompletion() {
        
        var username = phoneField.text
        var password = passwordField.text
        
        if firstNameField.text == "" || lastNameField.text == "" {
            let alert = UIAlertView(title: "Invalid", message: "Please enter your name.", delegate: self, cancelButtonTitle: "Return")
            alert.show()
        } else if (password!.characters.count) < 5 {
            let alert = UIAlertView(title: "Invalid", message: "Password must be greater than 5 characters.", delegate: self, cancelButtonTitle: "Return")
            alert.show()
        } else if (username!.characters.count) < 8 {
            let alert = UIAlertView(title: "Invalid", message: "Phone Number must be greater than 8 characters.", delegate: self, cancelButtonTitle: "Return")
            alert.show()
        }  else if password != repeatPassword.text {
            let alert = UIAlertView(title: "Invalid", message: "Passwords do not match.", delegate: self, cancelButtonTitle: "Return")
            alert.show()
        } else if birthday.text == "" {
            let alert = UIAlertView(title: "Invalid", message: "Please enter your birthdate.", delegate: self, cancelButtonTitle: "Return")
            alert.show()
        } else {
            attemptLogIn()
        }
    }
    
    func attemptLogIn() {
        
        let username = phoneField.text
        let password = passwordField.text
        let firstname = firstNameField.text
        let lastname = lastNameField.text
        let birthdate = birthday.text
        let inputsex: String = sex.titleForSegment(at: sex.selectedSegmentIndex)!
        self.actInd.startAnimating()
        let newUser = PFUser()
        newUser.username = username
        newUser.password = password
        newUser["firstname"] = firstname
        newUser["lastname"] = lastname
        newUser["birthdate"] = birthdate
        newUser["sex"] = inputsex
        
        newUser.signUpInBackground(block: {(succeed, error) -> Void in
            self.actInd.stopAnimating()
            if ((error) != nil) {
                var alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "Return")
                alert.show()
            } else {
                var alert = UIAlertView(title: "Success", message: "Signed up", delegate: self, cancelButtonTitle: "Return")
                alert.show()
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "navi")
                self.present(vc!, animated: true, completion: nil)
            }
        })
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
