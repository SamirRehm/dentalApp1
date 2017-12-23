//
//  ScheduleAnAppointment.swift
//  dentalApp
//
//  Created by Choi on 2017-12-22.
//  Copyright © 2017 Sean Choi. All rights reserved.
//

import UIKit
import Foundation
import Parse

class ScheduleAnAppointment: UIViewController {

    @IBOutlet weak var appointmentType: UITextField!
    @IBOutlet weak var appointmentDate: UITextField!
    @IBOutlet weak var additionalComment: UITextField!
    var actInd: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 150, height: 150)) as UIActivityIndicatorView
    let datePicker = UIDatePicker()
    let types = [
        "Cleaning",
        "Checkup"
    ]
    
    var apptType: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpKeyboardToolBar()
        createTypePicker()
        createToolBar()
        additionalComment?.placeholder = "Additional Comment"
    }
    
    func createToolBar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        datePicker.datePickerMode = .date
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        
        appointmentDate.inputAccessoryView = toolBar
        appointmentDate.inputView = datePicker
        
    }
    
    @objc func doneClicked() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        appointmentDate.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    func createTypePicker() {
        let typePicker = UIPickerView()
        typePicker.delegate = self as! UIPickerViewDelegate
        
        appointmentType.inputView = typePicker
    }
    
    func setUpKeyboardToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        appointmentType.inputAccessoryView = toolBar
        appointmentDate.inputAccessoryView = toolBar
        additionalComment.inputAccessoryView = toolBar
        appointmentType.textContentType = UITextContentType("")
        appointmentDate.textContentType = UITextContentType("")
        additionalComment.textContentType = UITextContentType("")
        
    }
    
    @IBAction func submit(_ sender: Any) {
        
        let user = PFUser.current()!
        
        let apptType = appointmentType.text
        let apptDate = appointmentDate.text
        let addComment = additionalComment.text
        self.actInd.startAnimating()

        user["AppointmentType"] = apptType
        user["AppointmentDate"] = apptDate
        user["AdditionalComments"] = addComment
        user["Confirmation"] = false

       user.saveInBackground()
        
    }
    

}


extension ScheduleAnAppointment: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return types.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        apptType = types[row]
        appointmentType.text = apptType
    }
}
