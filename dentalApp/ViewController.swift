//
//  ViewController.swift
//  dentalApp
//
//  Created by Sean Choi on 2017-12-08.
//  Copyright © 2017 Sean Choi. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var Register: UIButton!
    @IBOutlet weak var clip: UIImageView!
    
    
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 150, height: 150)) as UIActivityIndicatorView
    
    var dayWeatherData: DayWeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNotification()
        initializeUsernameAndPasswordField()
        setUpKeyboardToolBar()
        autoLogin()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        autoLogin()
    }
    
    func initializeUsernameAndPasswordField() {
        phoneField?.placeholder = "867-XXX-XXXX"
        passwordField?.placeholder = "Password"
        login.layer.cornerRadius = 10
        Register.layer.cornerRadius = 10
        Register.layer.borderWidth = 1.0
        Register.layer.borderColor = UIColor(red: 79.0/255.0, green: 200.0/255.0, blue: 197.0/255.0, alpha: 1.0).cgColor
        passwordField?.isSecureTextEntry = true
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
    }
    
    func setUpNotification() {
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(self.actInd)
        
    }
    
    func setUpKeyboardToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        phoneField.inputAccessoryView = toolBar
        passwordField.inputAccessoryView = toolBar
        phoneField.textContentType = UITextContentType("")
        passwordField.textContentType = UITextContentType("")

    }
    
    @IBAction func loginAction(_ sender: Any) {
        
        var username = self.phoneField.text
        var password = self.passwordField.text
        
        view.endEditing(true)
        
        if username == "6049979710" && password == "qqqqq" {
            
            self.actInd.startAnimating()
            
            PFUser.logInWithUsername(inBackground: username!, password: password!, block: { (user, error) -> Void in
                self.actInd.stopAnimating()
                if ((user) != nil) {
                    let vc = UIStoryboard(name: "Dentist", bundle: nil).instantiateViewController(withIdentifier: "navi2")
                    self.present(vc, animated: true, completion: nil)
                    
                }
            })
            
            return
        }
        
        if (password!.characters.count) < 5 {
            var alert = UIAlertView(title: "Invalid", message: "Password must be greater than 5 characters.", delegate: self, cancelButtonTitle: "Return")
            alert.show()
        } else if (username!.characters.count) < 8 {
            var alert = UIAlertView(title: "Invalid", message: "Phone number must be greater than 8 characters.", delegate: self, cancelButtonTitle: "Return")
            alert.show()
        } else {
            self.actInd.startAnimating()
            
            PFUser.logInWithUsername(inBackground: username!, password: password!, block: { (user, error) -> Void in
                self.actInd.stopAnimating()
                if ((user) != nil) {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "navi")
                    self.present(vc!, animated: true, completion: nil)
                 
                } else {
                    let alert = UIAlertView(title: "Error", message: "Invalid Username or Password. Please try again.", delegate: self, cancelButtonTitle: "Return")
                    alert.show()
                }
        })
        
    }
    
    }

    
    @IBAction func signUpAction(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    
    func autoLogin() {
        
        if PFUser.current() == nil {
            print("")
            
        } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "navi")
                self.present(vc!, animated: true, completion: nil)

        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
        }
    }
    
}

