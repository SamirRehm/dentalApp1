//
//  Requests.swift
//  dentalApp
//
//  Created by Choi on 2017-12-22.
//  Copyright © 2017 Sean Choi. All rights reserved.
//

import UIKit
import Parse

class Requests: UITableViewController {
    var list = [PFObject]()
    var list2 = ["apple", "orange"]
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let query = PFUser.query()
         query?.whereKey("Confirmation", equalTo: false)
         query?.selectKeys(["firstname", "lastname", "AppointmentDate", "AppointmentType", "AdditionalComments"])
         query?.findObjectsInBackground {
         (objects:[PFObject]?, error:Error?) -> Void in
         if error == nil {
         // Do something with the found objects
         if let objects = objects {
         for object in objects {
         self.list.append(object)
         print(object["lastname"])
         }
         }
         } else {
         // Log details of the failure
         print("Error")
         }
         }
        print(list.count)
        return(2)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row] as? String
        return(cell)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

 
    }




}
