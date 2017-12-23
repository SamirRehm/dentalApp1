//
//  Dentist.swift
//  dentalApp
//
//  Created by naksung choi on 2017. 12. 22..
//  Copyright © 2017년 Sean Choi. All rights reserved.
//

import UIKit
import Parse
import Foundation

class Dentist: UIViewController {
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var welcomeView: UIView!
    @IBOutlet weak var trinitiLogo: UIImageView!
    @IBOutlet weak var headline: UIView!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var welcome: UILabel!
    @IBOutlet weak var ViewAppointmentRequests: UIButton!
    @IBOutlet weak var viewMySchedule: UIButton!
    @IBOutlet weak var viewMyPatientFiles: UIButton!
    @IBOutlet weak var contactMyPatients: UIButton!
    @IBOutlet weak var OtherInfo: UIButton!

    var degree: Int!
    var condition: String!
    var imgURL: String!
    var x = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayWhitehorseWeather()
        setUpAnimatedControls()
        setUpButtons()
        
        let query = PFUser.query()
        //query?.whereKey("firstname", notEqualTo: "")
        query?.selectKeys(["firstname"])
        query?.findObjectsInBackground {
            (objects:[PFObject]?, error:Error?) -> Void in
            if error == nil {
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print(object["firstname"])
                    }
                }
            } else {
                // Log details of the failure
                print("Error")
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        displayWeekdayAndDate()
        displayWhitehorseWeather()
        displayWelcomeSign()
        animateView()
    }
    
    
    func setUpAnimatedControls() {
        
        dayView.transform = CGAffineTransform(translationX: -dayView.frame.width, y: 0)
        weatherView.transform = CGAffineTransform(translationX: weatherView.frame.width, y: 0)
        
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -50
        horizontalMotionEffect.maximumRelativeValue = 50
        
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -50
        verticalMotionEffect.maximumRelativeValue = 50
        
        let motionEffectGroup = UIMotionEffectGroup()
        motionEffectGroup.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        
        background.addMotionEffect(motionEffectGroup)
        
    }
    
    func setUpButtons() {
        
        ViewAppointmentRequests.titleLabel?.textAlignment = NSTextAlignment.center
        viewMySchedule.titleLabel?.textAlignment = NSTextAlignment.center
        viewMyPatientFiles.titleLabel?.textAlignment = NSTextAlignment.center
        contactMyPatients.titleLabel?.textAlignment = NSTextAlignment.center
        OtherInfo.titleLabel?.textAlignment = NSTextAlignment.center
        
        ViewAppointmentRequests.layer.borderWidth = 0.5
        viewMySchedule.layer.borderWidth = 0.5
        viewMyPatientFiles.layer.borderWidth = 0.5
        contactMyPatients.layer.borderWidth = 0.5
        OtherInfo.layer.borderWidth = 0.5
        
        ViewAppointmentRequests.layer.borderColor = UIColor(red: 83.0/255.0, green: 186.0/255.0, blue: 183.0/255.0, alpha: 1.0).cgColor
        viewMySchedule.layer.borderColor = UIColor(red: 83.0/255.0, green: 186.0/255.0, blue: 183.0/255.0, alpha: 1.0).cgColor
        viewMyPatientFiles.layer.borderColor = UIColor(red: 83.0/255.0, green: 186.0/255.0, blue: 183.0/255.0, alpha: 1.0).cgColor
        contactMyPatients.layer.borderColor = UIColor(red: 83.0/255.0, green: 186.0/255.0, blue: 183.0/255.0, alpha: 1.0).cgColor
        OtherInfo.layer.borderColor = UIColor(red: 83.0/255.0, green: 186.0/255.0, blue: 183.0/255.0, alpha: 1.0).cgColor
    }
    
    
    func displayWeekdayAndDate() {
        Data.getDay{ (data) in
            if let data = data {
                self.dayLabel.text = data.dayName
                self.dateLabel.text = data.longDate
            }
        }
    }
    
    func displayWelcomeSign() {
        if x != 1 {
            x = 1
            let user = PFUser.current()!
            welcome.text = String("Welcome Dr. \(user["lastname"]!)!")
            self.welcome.alpha = 0.0
            self.welcomeView.alpha = 0.0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.40) {
                self.welcome.fadeIn()
                self.welcomeView.fadeIn()
                self.welcome.fadeOut(completion: {
                    (finished: Bool) -> Void in
                    self.trinitiLogo.alpha = 0.0
                    self.trinitiLogo.isHidden = false
                    self.trinitiLogo.fadeIn()
                })
                
            }
        }
    }
    
    
    func displayWhitehorseWeather() {
        let urlRequest = URLRequest(url: URL(string: "https://api.apixu.com/v1/current.json?key=7cd5a066e558490a8c1112448171012&q=Whitehorse")!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error == nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                    
                    if let current = json["current"] as? [String : AnyObject] {
                        if let temp = current["temp_c"] as? Int {
                            
                            DispatchQueue.main.async {
                                self.temperatureLabel.text = "\(temp)°"}
                        }
                        
                        if let condition = current["condition"] as? [String : AnyObject] {
                            //viewCon.condition = condition["text"] as! String
                            let icon = condition["icon"] as! String
                            self.imgURL = "https:\(icon)"
                            DispatchQueue.main.async{
                                self.weatherImageView.downloadImage(from: self.imgURL!)
                            }
                        }
                    }
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                }
            }
        }
        
        task.resume()
    }
    
    
    func animateView() {
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
            self.dayView.transform = .identity
            self.weatherView.transform = .identity
        }) { (success) in
            
        }
    }
    
    
    @IBAction func logout(_ sender: Any) {
        let dentist = Dentist()
        PFUser.logOut()
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login")
        self.present(vc, animated: true, completion: nil)
        dentist.dismiss(animated: true, completion: nil)
        
    }
    
}

